{%- comment -%}
CHANGE LOG PAGE — changes.md
{%- endcomment -%}

### Version 0.1.0 (DRAFT)

**Initial draft.** This guide is developed under the FHIR Community Process. It has been tested at a connectathon and is reviewed by subject matter experts and the HL7 Public Health Work Group.

- Initial profiles derived from US Core 8.0.1:
  - USCDI-SCD Patient
  - USCDI-SCD Practitioner
  - USCDI-SCD PractitionerRole
  - USCDI-SCD Organization
  - USCDI-SCD Location
  - USCDI-SCD Encounter
  - USCDI-SCD Condition Encounter Diagnosis
  - USCDI-SCD Condition Problems and Health Concerns
  - USCDI-SCD AllergyIntolerance
  - USCDI-SCD CarePlan
  - USCDI-SCD ServiceRequest
  - USCDI-SCD Medication
  - USCDI-SCD MedicationRequest
  - USCDI-SCD Procedure
  - USCDI-SCD Laboratory Result
  - USCDI-SCD Vital Signs
- Initial profile for FHIR 4.0.1 BiologicallyDerivedProduct
- Initial extensions for VOC frequency, newborn screening, iron chelation,
  transfusion antigen matching and blood product age
- Initial value sets for SCD diagnoses, acute complications, laboratory tests,
  vital signs, medications, procedures, blood product types, blood product
  processing and red cell antigens, and code systems for SCD observation
  categories and blood product processing
- Initial CapabilityStatements for server and client actors, importing the
  US Core 8.0.1 Server and Client CapabilityStatements. They list profiles in
  `supportedProfile` (not `resource.profile`), and declare `read` and
  `search-type` (SHOULD) for BiologicallyDerivedProduct
- Narrative guidance, including the Exchange Workflow, Data Element Mapping,
  Test Data, Glossary, References, and Known Issues and Open Questions pages
- Clinical and regulatory statements cited to published guidelines, drug
  labeling and regulations (References page); statements without a source
  were removed or marked for review
- Mapping of ONC's Version 1 USCDI+ SCD data elements to the profiles in
  this guide (USCDI+ SCD Data Elements page)
- Developer and Business Analyst reading paths on the Home page
- Exchange process, FHIR interaction and information model diagrams (SVG)
- Use case scenarios, an explicit out-of-scope list, a list of what this guide
  adds to US Core, and a conformance testing checklist
- SNOMED CT red cell antigen codes verified against the SNOMED CT US Edition

**Decisions made during review of this draft**

- Terminology approach: the guide adds no terminology constraints beyond
  US Core. The SCD value sets are reference lists. Five are linked to their
  profile elements as Additional Bindings with the purpose open, which do not
  constrain the element: SCD Diagnosis and SCD Acute Complication
  (`Condition.code`), SCD Procedure (`Procedure.code`), SCD Medication
  (`Medication.code` and `MedicationRequest.medication[x]`) and SCD Laboratory
  Panel (`Observation.code` in the Laboratory Result profile). The SCD-relevant
  values are maintained by ONC in the USCDI+ SCD data element lists. This
  resolves the former open question on binding strength (OQ-13, now a retired
  ID). See
  [Terminology Approach](terminology.html#terminology-approach).
- A separate hematologist review of the examples (OQ-24) is not planned; the
  item is retired.
- The former open question on sickle cell trait (OQ-12, now a retired ID) is
  resolved: SNOMED CT 417357006 does not include 16402000 Sickle cell trait.
- SCD Acute Complication Value Set: every billable ICD-10-CM D57 "with crisis"
  code added ([OQ-16](issues.html#oq-16)). SCD Laboratory Panel Value Set:
  LOINC 98979-8 (CKD-EPI 2021) and 9318-7 added, and 94538-6 for the hemoglobin
  HPLC and electrophoresis panel ([OQ-17](issues.html#oq-17))
- Client conformance levels: one set of client levels covers both use cases
  ([OQ-26](issues.html#oq-26))
- Reference targets narrowed to USCDI-SCD profiles are listed on the
  [Conformance Requirements](conformance.html#reference-targets) page,
  including the targets that US Core allows and this guide does not
  ([OQ-21](issues.html#oq-21))
- Feedback on this guide goes to ONC
- The publication pathway is recorded as a known issue ([KI-15](issues.html#ki-15))
- An example of the SCD Hydroxyurea Adherence extension, on a FHIR R4
  MedicationStatement
- Expected search results for Encounter, AllergyIntolerance, Procedure,
  CarePlan and ServiceRequest on the Test Data page
- New open questions on client levels per use case ([OQ-26](issues.html#oq-26)),
  content beyond ONC's Version 1 lists ([OQ-27](issues.html#oq-27)), the
  hydroxyurea adherence extension ([OQ-28](issues.html#oq-28)), the client
  display requirement ([OQ-29](issues.html#oq-29)) and the clinical realism of
  the examples ([OQ-30](issues.html#oq-30))
- Glossary terms added for clinical, security and FHIR tooling terms used in
  the guide

**Clinical and terminology review**

- Codes added to the reference value sets after clinical review, each verified
  on tx.fhir.org: acute complications (priapism, hemorrhagic stroke, delayed
  hemolytic transfusion reaction, acute kidney injury, osteomyelitis),
  laboratory tests (direct antiglobulin test, red cell antigen typing, liver
  iron concentration, blood culture, C-reactive protein), procedures
  (cholecystectomy, hip replacement, liver MRI, gene therapy, stem cell
  collection), washed red cells and the RhD antigen
- The blood pressure goal follows the 2023 correction to the ASH 2019
  guideline (below 130/80 mm Hg)
- ICD-10-CM copyright statement corrected to the US Core wording

**Readability and navigation changes**

- Home page: a status note (draft version, number of known issues and open
  questions, how to give feedback) and a coverage summary. The Guide Contents
  table, which repeated the menu, is replaced by a pointer to the menu
- Known Issues and Open Questions: a summary table with the impact of each
  item, an anchor for every item, the Must Support items that may be removed,
  a list of retired IDs, and items in numeric order. Mentions
  of KI and OQ IDs on other pages now link to the item
- Exchange Workflow, Step 3: searches for the US Core profiles that this guide
  uses directly (Provenance, CareTeam, Goal, Immunization, DiagnosticReport and
  three Observation profiles), including `_revinclude=Provenance:target`
- Scope and Usage: the US Core profiles used directly are listed for each use
  case, and Organization is listed for both use cases
- The data intermediary is described as an actor whose role is to be decided
  ([OQ-1](issues.html#oq-1)), on the Conformance Requirements, Exchange
  Workflow and Scope and Usage pages
- Data Element Mapping: US Core's "additional USCDI" marker is shown in its own
  column instead of in the description; each profile section starts with an
  element count and ends with a link back to the top. The CSV adds blank
  worksheet columns (Source System, Source Field, Available, Notes) and rows for
  the elements of the US Core profiles used directly
- Scope and Usage: an Expected Source Systems and New Data Capture table, linked
  from the business analyst reading paths
- The coverage of the USCDI+ SCD data elements is stated the same way on every
  page: of 75, 55 are represented in this guide's profiles, 15 in US Core
  profiles used directly, 3 partly and 2 not yet
- Guidance on where to record antigen matching (blood product and transfusion
  Procedure for the units transfused, the order for the matching requested), on
  where to use the SCD Newborn Screen Reference extension (the SCD Condition;
  the Patient only when no SCD Condition exists yet), and on linking transfused
  units through the transfusion order rather than `Procedure.usedReference`
- Figures: each figure links to the full-size SVG file. Figure 2 has a key that
  maps each box to its profile. Figure 3 refers to Figure 1 by number
- Glossary: a USCDI-SCD entry. Actors are named Client and Server throughout

---

<!-- Planned future versions: to be determined. -->
<!-- TODO: Document roadmap items for future STU or normative versions:
       - Addition of patient-reported outcome (PRO) profiles
       - Genomics profiles (the SCD subtype is currently carried in the diagnosis code)
       - Integration with Da Vinci prior authorization workflows
       - Alignment with FHIR R5 BiologicallyDerivedProduct improvements
       - International extensions (non-US SCD populations)
-->
