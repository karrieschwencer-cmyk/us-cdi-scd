// Generates input/pagecontent/uscdi-plus.md: maps each data element in ONC's
// USCDI+ SCD data element lists (scripts/data/onc-uscdi-plus-scd-*.json) to the
// profile and element that represents it. Every ONC data element must have an
// entry in M below, or the script fails.
//
// Usage:  node scripts/generate-uscdi-plus.js
// When ONC publishes a new version, update the JSON files in scripts/data/
// and the mapping in M, then rerun.
const fs = require('fs');
const path = require('path');
const dx = require('./data/onc-uscdi-plus-scd-diagnosis.json').rows, ec = require('./data/onc-uscdi-plus-scd-emergency-care.json').rows;

const P = id => `[USCDI-SCD ${id[0]}](StructureDefinition-uscdi-scd-${id[1]}.html)`;
const UC = (t, f) => `[US Core ${t}](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-${f}.html)`;
const pat = ['Patient', 'patient'], prac = ['Practitioner', 'practitioner'], role = ['PractitionerRole', 'practitionerrole'],
  loc = ['Location', 'location'], enc = ['Encounter', 'encounter'], cprob = ['Condition Problems and Health Concerns', 'condition-problems'],
  cenc = ['Condition Encounter Diagnosis', 'condition-encounter-diagnosis'], allergy = ['AllergyIntolerance', 'allergyintolerance'],
  cp = ['CarePlan', 'careplan'], mr = ['MedicationRequest', 'medicationrequest'], med = ['Medication', 'medication'],
  proc = ['Procedure', 'procedure'], lab = ['Laboratory Result', 'laboratory-result'], vs = ['Vital Signs', 'vital-signs'],
  bdp = ['BiologicallyDerivedProduct', 'biologicallyderivedproduct'];
// Data elements whose SCD-relevant values ONC lists in the USCDI+ "Additional
// Information" field. That field is not in the JSON files in scripts/data/;
// update this list by hand when ONC publishes a new version.
const VALUES = ['Care Plan', 'Diagnostic Imaging Test', 'Disability Status', 'Functional Status', 'Medications',
  'Mental/Cognitive Status', 'Problems', 'Procedures', 'SDOH Problems/Health Concerns', 'Tests'];
const S = 'USCDI-SCD profile', U = 'US Core profile used directly', PART = 'Partial', GAP = 'Not covered';

// name -> [where, elements, coverage, note]
const M = {
  'Assessment and Plan of Treatment': [P(cp), '`CarePlan.text`, `CarePlan.category`', S],
  'Care Plan': [P(cp), '`CarePlan.addresses`, `CarePlan.goal`, `CarePlan.activity`, `CarePlan.careTeam`', S],
  'Author': [UC('Provenance', 'us-core-provenance'), '`Provenance.agent.who`', U],
  'Author Organization': [UC('Provenance', 'us-core-provenance'), '`Provenance.agent.onBehalfOf`', U],
  'Author Role': [UC('Provenance', 'us-core-provenance'), '`Provenance.agent.type`', U],
  'Author Time Stamp': [UC('Provenance', 'us-core-provenance'), '`Provenance.recorded`', U],
  'Care Team Member Identifier': [P(prac), '`Practitioner.identifier`', S],
  'Care Team Member Location': [P(role), '`PractitionerRole.location`', S],
  'Care Team Member Name': [P(prac), '`Practitioner.name`', S],
  'Care Team Member Role': [UC('CareTeam', 'us-core-careteam') + ', ' + P(role), '`CareTeam.participant.role`, `PractitionerRole.code`', U, 'USCDI-SCD CarePlan references the care team (`CarePlan.careTeam`); there is no USCDI-SCD CareTeam profile.'],
  'Care Team Member Telecom': [P(role) + ', ' + P(prac), '`PractitionerRole.telecom`, `Practitioner.telecom`', S],
  'Current Address': [P(pat), '`Patient.address`', S],
  'Date of Birth': [P(pat), '`Patient.birthDate`', S],
  'Date of Death': [P(pat), '`Patient.deceased[x]`', S],
  'Email Address': [P(pat), '`Patient.telecom` (system `email`)', S],
  'Ethnicity': [P(pat), '`Patient.extension:ethnicity`', S],
  'First Name': [P(pat), '`Patient.name.given`', S],
  'Last Name': [P(pat), '`Patient.name.family`', S],
  'Middle Name (Including middle initial)': [P(pat), '`Patient.name.given`', S],
  'Name Suffix': [P(pat), '`Patient.name.suffix`', S],
  'Phone Number': [P(pat), '`Patient.telecom` (system `phone`)', S],
  'Previous Name': [P(pat), '`Patient.name` (with `use` = `old` or `name.period.end`)', S],
  'Race': [P(pat), '`Patient.extension:race`', S],
  'Sex': [P(pat), '`Patient.extension:sex`', S],
  'Date of Diagnosis': [P(cprob) + ', ' + P(cenc), '`Condition.onset[x]`; `Condition.extension:assertedDate` (Problems and Health Concerns only)', S],
  'Date of Resolution': [P(cprob) + ', ' + P(cenc), '`Condition.abatement[x]`', S],
  'Condition Evidence': [P(cprob) + ', ' + P(cenc), '`Condition.evidence.code`, `Condition.evidence.detail`', S],
  'Problems': [P(cprob), '`Condition.code` (see the [SCD Diagnosis Value Set](ValueSet-scd-diagnosis-vs.html))', S],
  'SDOH Problems/Health Concerns': [P(cprob), '`Condition.category` (`sdoh`), `Condition.code`', S],
  'Blood Genotype': [P(lab), '`Observation.code` (ABO group 883-9, Rh type 10331-7), `Observation.value[x]`', PART, 'Serologic ABO and Rh typing results can be sent as laboratory results. The guide has no guidance for blood group genotyping.'],
  'Variant Interpretation': ['—', '—', GAP, 'No profile or guidance for genetic variant results.'],
  'Dose': [P(mr), '`MedicationRequest.dosageInstruction.doseAndRate.dose[x]`', S],
  'Dose Unit of Measure': [P(mr), '`MedicationRequest.dosageInstruction.doseAndRate.doseQuantity.unit`, `.code`', S],
  'Medications': [P(mr) + ', ' + P(med), '`MedicationRequest.medication[x]`, `Medication.code`', S],
  'Facility Address': [P(loc), '`Location.address`', S],
  'Facility Identifier': [P(loc), '`Location.identifier`', S],
  'Facility Name': [P(loc), '`Location.name`', S],
  'Facility Type': [P(loc), '`Location.type`', S],
  'Tests': [P(lab), '`Observation.code`', S],
  'Values/Results': [P(lab), '`Observation.value[x]`, `Observation.component.value[x]`', S],
  'Blood Transfusion Product Antibody': [P(lab), '`Observation.code` (antibody screen 890-4, antibodies identified 888-8)', PART, 'The patient\'s antibody screen and identification can be sent as laboratory results. The blood product profile has no element for antibodies.'],
  'Blood Transfusion Product Antigen': [P(bdp), '`BiologicallyDerivedProduct.extension:scd-transfusion-antigen-match`', PART, 'Records the antigens matched for the transfusion, not the product\'s full antigen profile.'],
  'Blood Transfusion Product Blood Type': ['—', '—', GAP, 'FHIR R4 BiologicallyDerivedProduct has no element for the product\'s ABO/Rh type, and the guide defines no extension for it.'],
  'Blood Transfusion Product Name': [P(bdp), '`BiologicallyDerivedProduct.productCode`', S],
  'BMI Percentile (2 - 20 years)': [UC('Pediatric BMI for Age', 'pediatric-bmi-for-age'), '`Observation.value[x]`', U],
  'Body Height': [P(vs), '`Observation.code` (8302-2), `Observation.value[x]`', S],
  'Body Temperature': [P(vs), '`Observation.code` (8310-5), `Observation.value[x]`', S],
  'Body Weight': [P(vs), '`Observation.code` (29463-7), `Observation.value[x]`', S],
  'Diastolic Blood Pressure': [P(vs), '`Observation.component` (8462-4)', S],
  'Pulse Oximetry': [P(vs), '`Observation.code` (59408-5), `Observation.value[x]`', S],
  'Systolic Blood Pressure': [P(vs), '`Observation.component` (8480-6)', S],
  'Clinical Test': [UC('Observation Clinical Result', 'us-core-observation-clinical-result'), '`Observation.code`', U],
  'Clinical Test Result/Report': [UC('Observation Clinical Result', 'us-core-observation-clinical-result') + ', ' + UC('DiagnosticReport for Report and Note Exchange', 'us-core-diagnosticreport-note'), '`Observation.value[x]`, `DiagnosticReport.presentedForm`', U],
  'Diagnostic Imaging Test': [UC('Observation Clinical Result', 'us-core-observation-clinical-result') + ', ' + UC('DiagnosticReport for Report and Note Exchange', 'us-core-diagnosticreport-note'), '`Observation.code`, `DiagnosticReport.code`', U],
  'Diagnostic Imaging Report': [UC('DiagnosticReport for Report and Note Exchange', 'us-core-diagnosticreport-note'), '`DiagnosticReport.presentedForm`', U],
  'Disability Status': [UC('Observation Screening Assessment', 'us-core-observation-screening-assessment'), '`Observation.code`, `Observation.value[x]`', U],
  'Functional Status': [UC('Observation Screening Assessment', 'us-core-observation-screening-assessment'), '`Observation.code`, `Observation.value[x]`', U],
  'Mental/Cognitive Status': [UC('Observation Screening Assessment', 'us-core-observation-screening-assessment'), '`Observation.code`, `Observation.value[x]`', U],
  'Health Concerns': [P(cprob), '`Condition.category` (`health-concern`), `Condition.code`', S],
  'Pain Assessment': [P(vs), '`Observation.code` (38208-5 or 72514-3), `Observation.value[x]`', S],
  'Drug Class Allergy Intolerance': [P(allergy), '`AllergyIntolerance.code`', S],
  'Medication Allergy Intolerance': [P(allergy), '`AllergyIntolerance.code`', S],
  'Non-Medication Allergy Intolerance': [P(allergy), '`AllergyIntolerance.code`', S],
  'Reaction': [P(allergy), '`AllergyIntolerance.reaction.manifestation`', S],
  'Encounter Diagnosis': [P(enc) + ', ' + P(cenc), '`Encounter.diagnosis.condition`, `Condition.code`', S],
  'Encounter Disposition': [P(enc), '`Encounter.hospitalization.dischargeDisposition`', S],
  'Encounter Identifier': [P(enc), '`Encounter.identifier`', S],
  'Encounter Location': [P(enc), '`Encounter.location.location`', S],
  'Encounter Time': [P(enc), '`Encounter.period`', S],
  'Encounter Type': [P(enc), '`Encounter.type`', S],
  'Immunizations': [UC('Immunization', 'us-core-immunization'), '`Immunization.vaccineCode`', U],
  'Patient Goals': [UC('Goal', 'us-core-goal'), '`Goal.description`', U, 'USCDI-SCD CarePlan references goals (`CarePlan.goal`); there is no USCDI-SCD Goal profile.'],
  'Performance Time': [P(proc), '`Procedure.performed[x]`', S],
  'Blood Transfusion Date & Time': [P(proc), '`Procedure.performed[x]` (transfusion procedure)', S],
  'Procedures': [P(proc), '`Procedure.code`', S],
};

const els = new Map();
for (const [rows, uc] of [[dx, 'A'], [ec, 'B']]) for (const r of rows) {
  const [name, , , cls] = r;
  if (!els.has(name)) els.set(name, { name, cls, uc: new Set() });
  els.get(name).uc.add(uc);
}
const missing = [...els.keys()].filter(n => !M[n]);
if (missing.length) throw new Error('No mapping for: ' + missing.join(', '));
const extra = Object.keys(M).filter(n => !els.has(n));
if (extra.length) throw new Error('Mapping for unknown elements: ' + extra.join(', '));
const badValues = VALUES.filter(n => !els.has(n));
if (badValues.length) throw new Error('VALUES lists unknown elements: ' + badValues.join(', '));

// generate-mapping.js reads the mapping; write the page only when run directly.
const USE_CASES_BY_ELEMENT = Object.fromEntries([...els.values()].map((e) => [e.name, [...e.uc].sort()]));
module.exports = { M, VALUES, UC: USE_CASES_BY_ELEMENT, U };
if (require.main !== module) return;

const byClass = new Map();
for (const e of els.values()) { if (!byClass.has(e.cls)) byClass.set(e.cls, []); byClass.get(e.cls).push(e); }
const classes = [...byClass.keys()].sort((a, b) => a.localeCompare(b));
const count = c => [...els.values()].filter(e => M[e.name][2] === c).length;

let md = `{%- comment -%}
================================================================================
USCDI+ SCD DATA ELEMENTS PAGE — uscdi-plus.md
Generated from ONC's Version 1 USCDI+ SCD data element lists (retrieved
2026-10-26). Regenerate when ONC publishes a new version.
================================================================================
{%- endcomment -%}

This page maps each data element in ONC's Version 1 USCDI+ Sickle Cell Disease data element lists to where it is represented in this guide. It answers two questions: which profile and element carries each data element, and which data elements are not yet covered.

The lists are published by ONC for the [SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) use case (A, ${dx.length} data elements) and the [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) use case (B, ${ec.length} data elements). Together they contain ${els.size} distinct data elements. Of these, ${count(S)} are represented in this guide's profiles, ${count(U)} in US Core profiles used directly, ${count(PART)} partly and ${count(GAP)} not yet.

For the requirements on each profile element (cardinality, Must Support and bindings), see [Data Element Mapping](data-element-mapping.html).

### Coverage Summary

| Coverage | Meaning | Data elements |
|---|---|---|
| **${S}** | Represented in a profile defined by this guide | ${count(S)} |
| **${U}** | Represented in a US Core 8.0.1 profile that servers must support through the imported [US Core Server CapabilityStatement](http://hl7.org/fhir/us/core/STU8.0.1/CapabilityStatement-us-core-server.html); this guide adds no SCD-specific profile | ${count(U)} |
| **${PART}** | Partly represented; see the note | ${count(PART)} |
| **${GAP}** | Not represented in this guide | ${count(GAP)} |

US Core 8.0.1 implements USCDI v5. Data elements that are also USCDI data elements follow the [US Core USCDI mapping](http://hl7.org/fhir/us/core/STU8.0.1/uscdi.html).

### SCD-Relevant Values

For ${VALUES.length} data elements, ONC lists the SCD-relevant values in the "Additional Information" field of the USCDI+ data element: ${[...VALUES].sort().slice(0, -1).join(', ')} and ${[...VALUES].sort().slice(-1)}. ${VALUES.filter(n => els.get(n).uc.size > 1).sort().join(', ').replace(/, ([^,]*)$/, ' and $1')} are on both lists; the others are on the SCD Emergency Care list only. USCDI+ is where these values are maintained. This guide adds no terminology constraints for them beyond US Core; its value sets are reference lists (see [Terminology Approach](terminology.html#terminology-approach)). These data elements are noted in the tables below. Feedback on the values goes to ONC (see [How to Give Feedback](audience.html#how-to-give-feedback)).

### Gaps and Partial Coverage

`;
for (const c of [GAP, PART]) for (const e of [...els.values()].filter(e => M[e.name][2] === c).sort((a, b) => a.name.localeCompare(b.name)))
  md += `- **${e.name}** (${e.cls}; use case${e.uc.size > 1 ? 's' : ''} ${[...e.uc].sort().join(' and ')}): ${c}. ${M[e.name][3]}\n`;
md += `
These items are also listed as [KI-11](issues.html#ki-11) on the Known Issues and Open Questions page.

### Mapping by Data Class

Use case: **A** = SCD Diagnosis, **B** = SCD Emergency Care.
`;
for (const cls of classes) {
  md += `\n#### ${cls}\n\n| Data element | Use case | Profile | Element(s) | Coverage |\n|---|---|---|---|---|\n`;
  for (const e of byClass.get(cls).sort((a, b) => a.name.localeCompare(b.name))) {
    const [where, elems, cov, note] = M[e.name];
    const vals = VALUES.includes(e.name) ? `${note ? '' : '.'} SCD-relevant values: see the "Additional Information" field in USCDI+.` : '';
    md += `| ${e.name} | ${[...e.uc].sort().join(', ')} | ${where} | ${elems} | ${cov}${note ? ': ' + note : ''}${vals} |\n`;
  }
}
md += `
### Elements in This Guide Beyond the Version 1 Lists

The following parts of this guide do not correspond to a data element in the Version 1 lists. They support the use cases, but whether to keep them in this version is an open question ([OQ-27](issues.html#oq-27)).

| Artifact | Purpose |
|---|---|
| [SCD Vaso-Occlusive Crisis Frequency](StructureDefinition-scd-voc-frequency.html) | Number of VOC episodes over a period |
| [SCD Newborn Screen Reference](StructureDefinition-scd-newborn-screen-reference.html) | Link to the newborn screening result that identified SCD |
| [SCD Iron Chelation Indication](StructureDefinition-scd-iron-chelation-indication.html) | Why iron chelation therapy was started |
| [SCD Hydroxyurea Adherence](StructureDefinition-scd-hydroxyurea-adherence.html) | Hydroxyurea adherence assessment |
| [SCD Blood Product Age at Transfusion](StructureDefinition-scd-blood-product-age.html) | Age of the blood product at transfusion |
| [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html) | Referrals and orders; links transfusion procedures to blood products |
`;
fs.writeFileSync(path.join(__dirname, '..', 'input', 'pagecontent', 'uscdi-plus.md'), md);
console.log('elements', els.size, 'S', count(S), 'U', count(U), 'PART', count(PART), 'GAP', count(GAP));
