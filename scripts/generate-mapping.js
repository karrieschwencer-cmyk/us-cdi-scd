#!/usr/bin/env node
// ==============================================================================
// generate-mapping.js
//
// Generates the USCDI-SCD data element mapping chart from the profile
// StructureDefinitions, so the chart always matches the profiles.
//
// Inputs (run AFTER a full IG Publisher build, from the repo root):
//   output/StructureDefinition-*.json         profile and extension snapshots
//   fsh-generated/resources/*.json            differentials, value sets, examples
//
// Outputs:
//   input/pagecontent/data-element-mapping.md       the IG page
//   input/images/uscdi-scd-data-element-mapping.csv the tester download
//
// Usage:  node scripts/generate-mapping.js
// Then rebuild the IG so the regenerated page is published.
// ==============================================================================

const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const OUTPUT = path.join(ROOT, 'output');
const GEN = path.join(ROOT, 'fsh-generated', 'resources');
const PAGE = path.join(ROOT, 'input', 'pagecontent', 'data-element-mapping.md');
const CSV = path.join(ROOT, 'input', 'images', 'uscdi-scd-data-element-mapping.csv');
const CANON = 'http://hl7.org/fhir/us/uscdi-scd/';

// Use cases per profile, derived from the USCDI+ SCD Data Elements mapping
// (uscdi-plus.md): a profile belongs to a use case if it carries a data element
// on ONC's list for that use case. Keep in sync with the Scope and Usage page.
const BOTH = ['SCD Diagnosis', 'SCD Emergency Care'];
const USE_CASES = {
  'uscdi-scd-patient': BOTH,
  'uscdi-scd-practitioner': BOTH,
  'uscdi-scd-practitionerrole': BOTH,
  'uscdi-scd-location': BOTH,
  'uscdi-scd-condition-problems': BOTH,
  'uscdi-scd-condition-encounter-diagnosis': BOTH,
  'uscdi-scd-laboratory-result': BOTH,
  'uscdi-scd-medication': BOTH,
  'uscdi-scd-medicationrequest': BOTH,
  'uscdi-scd-careplan': BOTH,
  'uscdi-scd-encounter': ['SCD Emergency Care'],
  'uscdi-scd-vital-signs': ['SCD Emergency Care'],
  'uscdi-scd-allergyintolerance': ['SCD Emergency Care'],
  'uscdi-scd-procedure': ['SCD Emergency Care'],
  'uscdi-scd-biologicallyderivedproduct': ['SCD Emergency Care'],
};

// Display order (matches the Profiles page).
const ORDER = [
  'uscdi-scd-patient', 'uscdi-scd-practitioner', 'uscdi-scd-practitionerrole',
  'uscdi-scd-organization', 'uscdi-scd-location', 'uscdi-scd-encounter',
  'uscdi-scd-condition-problems', 'uscdi-scd-condition-encounter-diagnosis',
  'uscdi-scd-medication', 'uscdi-scd-medicationrequest',
  'uscdi-scd-allergyintolerance', 'uscdi-scd-careplan',
  'uscdi-scd-servicerequest', 'uscdi-scd-procedure',
  'uscdi-scd-laboratory-result', 'uscdi-scd-vital-signs',
  'uscdi-scd-biologicallyderivedproduct',
];

const readJson = (f) => JSON.parse(fs.readFileSync(f, 'utf8'));

// --- Load resources ---------------------------------------------------------
const titles = {}; // canonical -> title, for all local and dependency artifacts
for (const f of fs.readdirSync(GEN).filter((n) => n.endsWith('.json'))) {
  const r = readJson(path.join(GEN, f));
  if (r.url) titles[r.url] = r.title || r.name;
}

const profiles = {};
const extensions = {};
for (const f of fs.readdirSync(OUTPUT).filter((n) => /^StructureDefinition-.*\.json$/.test(n))) {
  const sd = readJson(path.join(OUTPUT, f));
  if (!sd.url || !sd.url.startsWith(CANON) || !sd.snapshot) continue;
  if (sd.type === 'Extension') extensions[sd.url] = sd;
  else profiles[sd.id] = sd;
}

const differentialIds = (id) => {
  const f = path.join(GEN, `StructureDefinition-${id}.json`);
  if (!fs.existsSync(f)) return new Set();
  return new Set((readJson(f).differential?.element || []).map((e) => e.id));
};

// Parent profiles (US Core and FHIR core) from the local FHIR package cache,
// used to tell whether this guide actually changed an element.
const PKG = path.join(process.env.USERPROFILE || process.env.HOME, '.fhir', 'packages');
const parentCache = {};
function loadParent(url) {
  if (parentCache[url] !== undefined) return parentCache[url];
  parentCache[url] = null;
  for (const pkg of ['hl7.fhir.us.core#8.0.1', 'hl7.fhir.r4.core#4.0.1']) {
    const dir = path.join(PKG, pkg, 'package');
    if (!fs.existsSync(dir)) continue;
    for (const f of fs.readdirSync(dir).filter((n) => n.startsWith('StructureDefinition-'))) {
      const sd = readJson(path.join(dir, f));
      if (sd.title || sd.name) titles[sd.url] = sd.title || sd.name;
      if (sd.url === url) parentCache[url] = sd;
    }
  }
  return parentCache[url];
}

const sig = (e) => JSON.stringify([
  e.min, e.max, !!e.mustSupport,
  (e.type || []).map((t) => [t.code, (t.targetProfile || []).map((p) => p.split('|')[0]).sort()]),
  e.binding?.valueSet?.split('|')[0] || '', e.binding?.strength || '',
]);

// True when this guide adds the element or changes its cardinality, Must
// Support flag, types/targets or binding compared with the parent profile.
function changedFromParent(e, parentById) {
  const p = parentById.get(e.id);
  return !p || sig(p) !== sig(e);
}

// Examples per profile (by meta.profile).
const examplesByProfile = {};
for (const f of fs.readdirSync(GEN).filter((n) => n.endsWith('.json'))) {
  const r = readJson(path.join(GEN, f));
  if (['StructureDefinition', 'ValueSet', 'CodeSystem', 'ImplementationGuide', 'CapabilityStatement', 'Bundle'].includes(r.resourceType)) continue;
  for (const p of r.meta?.profile || []) {
    (examplesByProfile[p] ||= []).push({ type: r.resourceType, id: r.id });
  }
}

// --- Helpers ----------------------------------------------------------------
const shortName = (url) => {
  const base = url.split('|')[0];
  if (titles[base]) return titles[base];
  return base.split('/').pop();
};

const typeText = (e) => (e.type || []).map((t) => {
  if (t.code === 'Extension' && t.profile) return `Extension(${t.profile.map(shortName).join(', ')})`;
  if (t.targetProfile) return `Reference(${t.targetProfile.map(shortName).join(' | ')})`;
  return t.code;
}).join(' | ');

// VSAC value set titles from the local package cache, so bindings show a title
// rather than a bare OID. Version 0.19.0 (the dependency) is tried first; a
// value set it lacks is looked up in other cached VSAC versions.
const VS_PACKAGES = ['us.nlm.vsac#0.19.0']
  .concat(fs.existsSync(PKG) ? fs.readdirSync(PKG).filter((n) => /^us\.nlm\.vsac#/.test(n) && n !== 'us.nlm.vsac#0.19.0').sort().reverse() : []);
function valueSetTitle(url) {
  const base = url.split('|')[0];
  if (titles[base]) return titles[base];
  const id = base.split('/').pop();
  if (!/^\d+(\.\d+)+$/.test(id)) return id; // only bare OIDs need a title
  for (const pkg of VS_PACKAGES) {
    const f = path.join(PKG, pkg, 'package', `ValueSet-${id}.json`);
    if (!fs.existsSync(f)) continue;
    const vs = readJson(f);
    if (vs.url === base && (vs.title || vs.name)) return (titles[base] = vs.title || vs.name);
  }
  return id;
}

const bindingText = (e) => {
  if (!e.binding?.valueSet) return '';
  return `${valueSetTitle(e.binding.valueSet)} (${e.binding.strength})`;
};

// USCDI+ SCD data elements per profile element, from the mapping used for the
// USCDI+ SCD Data Elements page (generate-uscdi-plus.js). An element path that
// is not itself listed in the chart is attached to its nearest listed parent.
const { M: USCDI_PLUS_MAP, UC: USCDI_PLUS_UC, U: US_CORE_COVERAGE } = require('./generate-uscdi-plus.js');
function uscdiPlusIndex(profileId, rootType, rowIds) {
  const index = new Map();
  for (const [name, [where, elems]] of Object.entries(USCDI_PLUS_MAP)) {
    const ids = [...where.matchAll(/StructureDefinition-(uscdi-scd-[a-z-]+)\.html/g)].map((m) => m[1]);
    if (!ids.includes(profileId)) continue;
    for (const [, p] of elems.matchAll(/`([A-Z][A-Za-z]+(?:\.[A-Za-z[\]:-]+)+)`/g)) {
      if (p.split('.')[0] !== rootType) continue;
      let id = p;
      while (id.includes('.') && !rowIds.has(id)) id = id.substring(0, id.lastIndexOf('.'));
      if (!rowIds.has(id)) continue;
      if (!index.has(id)) index.set(id, new Set());
      index.get(id).add(name);
    }
  }
  return index;
}

const SKIP = /\.(id|meta|implicitRules|language|text|contained|modifierExtension)$/;

// Keep Must Support elements, required elements under a kept parent, and
// extension slices this guide defines; skip infrastructure elements.
function selectElements(sd, diff) {
  const kept = new Set();
  const rows = [];
  const root = sd.type;
  for (const e of sd.snapshot.element) {
    if (e.id === root || SKIP.test(e.path)) continue;
    if (/\.extension$/.test(e.id) || /\.extension\.(url|value\[x\])$/.test(e.path) && !e.sliceName) continue;
    const parentId = e.id.substring(0, e.id.lastIndexOf('.'));
    const parentKept = parentId === root || kept.has(parentId);
    const isExtSlice = /extension:[^.]+$/.test(e.id);
    const scdExtSlice = isExtSlice && diff.has(e.id);
    const include = e.mustSupport || (e.min >= 1 && parentKept) || scdExtSlice;
    if (!include || (!parentKept && !e.mustSupport && !scdExtSlice)) continue;
    kept.add(e.id);
    rows.push(e);
  }
  return rows;
}

const esc = (s) => String(s ?? '').replace(/\|/g, '\\|').replace(/\r?\n+/g, ' ').trim();

// US Core marks additional USCDI requirements by starting the short description
// with "ADDITIONAL USCDI:", written in Unicode mathematical bold letters. The
// marker is removed from the description and shown in its own column instead.
const USCDI_MARKER = /(?:\u{1D5D4}\u{1D5D7}\u{1D5D7}\u{1D5DC}\u{1D5E7}\u{1D5DC}\u{1D5E2}\u{1D5E1}\u{1D5D4}\u{1D5DF}\s+\u{1D5E8}\u{1D5E6}\u{1D5D6}\u{1D5D7}\u{1D5DC}|ADDITIONAL USCDI)\s*:\s*/gu;
const additionalUscdi = (s) => (String(s ?? '').match(USCDI_MARKER) ? 'Y' : '');
const stripMarker = (s) => String(s ?? '').replace(USCDI_MARKER, '').trim();
const csvCell = (s) => `"${String(s ?? '').replace(/"/g, '""').replace(/\r?\n+/g, ' ').trim()}"`;

// --- Build ------------------------------------------------------------------
// The last four columns are left blank: a gap analysis worksheet for each
// organization to fill in.
const WORKSHEET = ['', '', '', ''];
const csvRows = [[
  'USCDI+ SCD Data Element', 'Use Case', 'Profile', 'Element', 'Cardinality',
  'Must Support', 'Type', 'Binding', 'Source', 'Additional USCDI (US Core)', 'Description',
  'Source System', 'Source Field', 'Available (Y/N/Partial)', 'Notes',
]];

let md = `<a id="top"></a>

This page maps the data elements in this guide to their FHIR profiles and elements. It lists every Must Support element and every required element for each profile, with its cardinality, data type and terminology binding. It is generated from the profile definitions, so it always matches them.

**Download:** [uscdi-scd-data-element-mapping.csv](uscdi-scd-data-element-mapping.csv) (opens in Excel)

**Source data elements:** ONC publishes the USCDI+ Sickle Cell Disease data element lists on the USCDI+ site: [SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp). For where each of those data elements is represented in this guide, see [USCDI+ SCD Data Elements](uscdi-plus.html). The CSV download also has a "USCDI+ SCD Data Element" column that names, for each profile element, the USCDI+ SCD data elements it carries, taken from that page. The CSV also lists the elements of the US Core profiles that this guide uses directly for some USCDI+ SCD data elements (Source **US Core**). Its last four columns (Source System, Source Field, Available (Y/N/Partial) and Notes) are blank, for use as a gap analysis worksheet.

### How to read this chart

| Column | Meaning |
|---|---|
| Element | The FHIR element path. A name after a colon (for example, \`extension:scd-voc-frequency\`) is a named slice. |
| Card. | Cardinality: minimum..maximum occurrences. A minimum of 1 means the element is required. |
| MS | **Y** means the element is Must Support. See [Must Support](conformance.html#must-support). |
| Type | The data type. For references, the profiles the reference must conform to. |
| Binding | The value set the element's codes come from, and the binding strength. |
| Source | **USCDI-SCD** if this guide adds or changes the element; **Inherited** if it comes unchanged from the parent profile (usually US Core). |
| Additional USCDI (US Core) | **Y** means US Core marks the element as an additional USCDI requirement. See [Additional USCDI Requirement](glossary.html). |

Elements inherited from US Core are included so testers can see every requirement in one place. Child elements are listed only when their parent is listed.

`;

const profileIds = ORDER.filter((id) => profiles[id]).concat(Object.keys(profiles).filter((id) => !ORDER.includes(id)));
const usedExtensions = new Set();

for (const id of profileIds) {
  const sd = profiles[id];
  const diff = differentialIds(id);
  const parentSd = loadParent(sd.baseDefinition);
  const parentById = new Map((parentSd?.snapshot?.element || []).map((e) => [e.id, e]));
  const parent = shortName(sd.baseDefinition);
  const useCases = (USE_CASES[id] || []).join(', ') || 'Supporting';
  const examples = (examplesByProfile[sd.url] || []).map((x) => `[${x.id}](${x.type}-${x.id}.html)`).join(', ');

  const rows = selectElements(sd, diff);
  const msAdded = rows.filter((e) => e.mustSupport && !parentById.get(e.id)?.mustSupport).length;
  md += `---\n\n### [${sd.title}](StructureDefinition-${id}.html)\n\n`;
  md += `${rows.length} element${rows.length === 1 ? '' : 's'}; ${msAdded} Must Support added by this guide.\n\n`;
  md += `**Parent:** ${parent} &nbsp;·&nbsp; **Use case:** ${useCases}${examples ? ` &nbsp;·&nbsp; **Examples:** ${examples}` : ''}\n\n`;
  md += '<div style="overflow-x:auto" markdown="1">\n\n';
  md += '| Element | Card. | MS | Type | Binding | Source | Additional USCDI (US Core) | Description |\n|---|---|---|---|---|---|---|---|\n';

  const plus = uscdiPlusIndex(id, sd.type, new Set(rows.map((e) => e.id)));
  for (const e of rows) {
    for (const t of e.type || []) if (t.code === 'Extension') (t.profile || []).forEach((p) => usedExtensions.add(p.split('|')[0]));
    const source = changedFromParent(e, parentById) ? 'USCDI-SCD' : 'Inherited';
    const card = `${e.min}..${e.max}`;
    const ms = e.mustSupport ? 'Y' : '';
    md += `| \`${esc(e.id)}\` | ${card} | ${ms} | ${esc(typeText(e))} | ${esc(bindingText(e))} | ${source} | ${additionalUscdi(e.short)} | ${esc(stripMarker(e.short))} |\n`;
    csvRows.push([[...(plus.get(e.id) || [])].sort().join('; '), useCases, sd.title, e.id, card, ms, typeText(e), bindingText(e), source, additionalUscdi(e.short), stripMarker(e.short), ...WORKSHEET]);
  }
  md += '\n</div>\n\n[Back to top](#top)\n\n';
}

// Extension detail: sub-elements of the SCD extensions used by the profiles.
md += `---\n\n### Extension Details\n\nThe parts of each SCD extension used in the profiles above.\n\n`;
md += '<div style="overflow-x:auto" markdown="1">\n\n';
md += '| Extension | Part | Card. | Type | Binding | Description |\n|---|---|---|---|---|---|\n';
for (const url of [...usedExtensions].filter((u) => extensions[u]).sort()) {
  const sd = extensions[url];
  const link = `[${sd.title}](StructureDefinition-${sd.id}.html)`;
  const subs = sd.snapshot.element.filter((e) => /^Extension\.extension:[^.]+$/.test(e.id));
  const parts = subs.length
    ? subs.map((s) => ({ name: s.sliceName, e: s, v: sd.snapshot.element.find((x) => x.id === `${s.id}.value[x]`) }))
    : [{ name: '(value)', e: sd.snapshot.element.find((x) => x.id === 'Extension'), v: sd.snapshot.element.find((x) => x.id === 'Extension.value[x]') }];
  for (const p of parts) {
    const card = `${p.e.min}..${p.e.max}`;
    md += `| ${link} | ${p.name} | ${card} | ${esc(p.v ? typeText(p.v) : '')} | ${esc(p.v ? bindingText(p.v) : '')} | ${esc(p.e.short || sd.title)} |\n`;
    csvRows.push(['', '', sd.title, `${sd.id}:${p.name}`, card, '', p.v ? typeText(p.v) : '', p.v ? bindingText(p.v) : '', 'USCDI-SCD', additionalUscdi(p.e.short), stripMarker(p.e.short || sd.title), ...WORKSHEET]);
  }
}
md += '\n</div>\n\n[Back to top](#top)\n';

// CSV only: elements of the US Core profiles that this guide uses directly for
// some USCDI+ SCD data elements (coverage "US Core profile used directly" on the
// USCDI+ SCD Data Elements page). Values come from the US Core 8.0.1 snapshots.
const USE_CASE_NAMES = { A: 'SCD Diagnosis', B: 'SCD Emergency Care' };
const usCoreRows = new Map(); // "profileUrl|elementPath" -> { url, path, names, uc }
for (const [name, [where, elems, cov]] of Object.entries(USCDI_PLUS_MAP)) {
  if (cov !== US_CORE_COVERAGE) continue;
  const urls = [...where.matchAll(/STU8\.0\.1\/StructureDefinition-([a-z-]+)\.html/g)]
    .map((m) => `http://hl7.org/fhir/us/core/StructureDefinition/${m[1]}`);
  const paths = [...elems.matchAll(/`([A-Z][A-Za-z]+(?:\.[A-Za-z[\]:-]+)+)`/g)].map((m) => m[1]);
  for (const url of urls) {
    const sd = loadParent(url);
    if (!sd) throw new Error(`US Core profile not found in the package cache: ${url}`);
    for (const p of paths.filter((x) => x.split('.')[0] === sd.type)) {
      const key = `${url}|${p}`;
      if (!usCoreRows.has(key)) usCoreRows.set(key, { sd, path: p, names: new Set(), uc: new Set() });
      usCoreRows.get(key).names.add(name);
      (USCDI_PLUS_UC[name] || []).forEach((u) => usCoreRows.get(key).uc.add(u));
    }
  }
}
for (const { sd, path: p, names, uc } of [...usCoreRows.values()].sort((a, b) => (a.sd.title + a.path).localeCompare(b.sd.title + b.path))) {
  const e = sd.snapshot.element.find((x) => x.id === p);
  if (!e) throw new Error(`Element ${p} not found in ${sd.url}`);
  csvRows.push([[...names].sort().join('; '), [...uc].sort().map((u) => USE_CASE_NAMES[u]).join(', '), sd.title, p,
    `${e.min}..${e.max}`, e.mustSupport ? 'Y' : '', typeText(e), bindingText(e), 'US Core', additionalUscdi(e.short), stripMarker(e.short), ...WORKSHEET]);
}

fs.writeFileSync(PAGE, md, 'utf8');
fs.mkdirSync(path.dirname(CSV), { recursive: true });
fs.writeFileSync(CSV, '﻿' + csvRows.map((r) => r.map(csvCell).join(',')).join('\r\n') + '\r\n', 'utf8');
console.log(`Wrote ${path.relative(ROOT, PAGE)} and ${path.relative(ROOT, CSV)} (${csvRows.length - 1} rows, ${profileIds.length} profiles, ${usedExtensions.size} extensions, ${usCoreRows.size} US Core rows).`);
