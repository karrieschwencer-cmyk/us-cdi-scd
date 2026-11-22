"""Write input/images/uscdi-scd-reference-value-sets.xlsx from the guide's value sets.

The value sets in input/fsh/valuesets are the single source: run SUSHI first, then
this script, so the download always matches the guide. Requires Python 3 and openpyxl.

Usage (from the repository root):  python scripts/generate-value-set-workbook.py
"""
import glob
import json
import os

from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
RES = os.path.join(ROOT, "fsh-generated", "resources")
OUT = os.path.join(ROOT, "input", "images", "uscdi-scd-reference-value-sets.xlsx")
SYSTEMS = {
    "http://snomed.info/sct": "SNOMED CT",
    "http://loinc.org": "LOINC",
    "http://www.nlm.nih.gov/research/umls/rxnorm": "RxNorm",
    "http://hl7.org/fhir/sid/icd-10-cm": "ICD-10-CM",
}
FONT = "Arial"


def load(pattern):
    items = {}
    for path in glob.glob(os.path.join(RES, pattern)):
        with open(path, encoding="utf-8") as f:
            res = json.load(f)
        items[res["url"]] = res
    return items


def concepts(vs, codesystems):
    rows = []
    for inc in vs.get("compose", {}).get("include", []):
        system = inc.get("system", "")
        if "concept" in inc:
            for c in inc["concept"]:
                rows.append((system, c["code"], c.get("display", "")))
        elif system in codesystems:  # include of a whole local code system
            for c in codesystems[system].get("concept", []):
                rows.append((system, c["code"], c.get("display", "")))
    return rows


def main():
    valuesets = load("ValueSet-*.json")
    codesystems = load("CodeSystem-*.json")
    if not valuesets:
        raise SystemExit("No ValueSet resources in fsh-generated/resources: run SUSHI first.")

    head_font = Font(name=FONT, bold=True, color="FFFFFF")
    head_fill = PatternFill("solid", fgColor="1F4E79")
    body = Font(name=FONT, size=10)
    wrap = Alignment(wrap_text=True, vertical="top")
    side = Side(style="thin", color="BFBFBF")
    box = Border(left=side, right=side, top=side, bottom=side)

    wb = Workbook()
    about = wb.active
    about.title = "About"
    lines = [
        ("USCDI-SCD reference value sets", True),
        ("These are the value sets defined in the USCDI+ Sickle Cell Disease Implementation Guide, one sheet each. "
         "They are reference lists of codes commonly used in SCD care, for example for building test data. "
         "They do not constrain exchange: the US Core bindings apply. See the Terminology page of the guide.", False),
        ("This file is generated from the guide's value set definitions each time the guide is built, so it always "
         "matches the published value sets.", False),
        ("", False),
        ("Value set  |  Codes", True),
    ]
    for i, (text, bold) in enumerate(lines, 1):
        cell = about.cell(row=i, column=1, value=text)
        cell.font = Font(name=FONT, size=12 if i == 1 else 10, bold=bold)
        cell.alignment = wrap
    about.column_dimensions["A"].width = 110
    r = len(lines) + 1

    for url, vs in sorted(valuesets.items(), key=lambda kv: kv[1].get("title", kv[0])):
        rows = concepts(vs, codesystems)
        title = vs.get("title", vs.get("name", url))
        ws = wb.create_sheet(title.replace("SCD ", "").replace(" Value Set", "")[:31])
        ws.cell(row=1, column=1, value=title).font = Font(name=FONT, size=11, bold=True)
        ws.cell(row=2, column=1, value="Canonical URL: " + url).font = Font(name=FONT, size=9, italic=True)
        for j, h in enumerate(["Code system", "Code", "Display"], 1):
            c = ws.cell(row=4, column=j, value=h)
            c.font, c.fill, c.border, c.alignment = head_font, head_fill, box, wrap
        for k, (system, code, display) in enumerate(rows, 5):
            vals = [SYSTEMS.get(system, codesystems.get(system, {}).get("title", system)), code, display]
            for j, v in enumerate(vals, 1):
                c = ws.cell(row=k, column=j, value=v)
                c.font, c.border, c.alignment = body, box, wrap
                if j == 2:
                    c.number_format = "@"
        ws.column_dimensions["A"].width = 18
        ws.column_dimensions["B"].width = 20
        ws.column_dimensions["C"].width = 90
        ws.freeze_panes = "A5"
        ws.auto_filter.ref = f"A4:C{max(4, len(rows) + 4)}"
        about.cell(row=r, column=1, value=f"{title}  |  {len(rows)}").font = body
        r += 1

    wb.save(OUT)
    print(f"Wrote {os.path.relpath(OUT, ROOT)} ({len(valuesets)} value sets)")


if __name__ == "__main__":
    main()
