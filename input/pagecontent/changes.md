{%- comment -%}
CHANGE LOG PAGE — changes.md
List major changes and decisions only. Editorial and readability changes are
recorded in the source history, not here.
{%- endcomment -%}

### Version 0.1.0 (DRAFT)

**Initial draft.** This guide is developed under the FHIR Community Process. It has been tested at a connectathon and is reviewed by subject matter experts and the HL7 Public Health Work Group.

**Content**

- 17 profiles: 16 derived from US Core 8.0.1, and one for the FHIR R4 BiologicallyDerivedProduct resource
- 6 extensions, 9 value sets and 2 local code systems for SCD-specific data
- Server and client CapabilityStatements that import the US Core 8.0.1 CapabilityStatements
- A mapping of ONC's Version 1 USCDI+ SCD data elements to the profiles
- Examples and test data for a fictional patient, with expected search results
- The value sets as a downloadable spreadsheet, generated from the value set definitions

**Decisions**

- **Terminology approach.** The guide adds no terminology constraints beyond US Core. Its value sets are reference lists: six are linked to profile elements as non-constraining Additional Bindings (purpose `starter`), and three are example bindings. ONC maintains the SCD-relevant values in USCDI+. See [Terminology Approach](terminology.html#terminology-approach).
- **Feedback** on this guide goes to ONC.
- **Resolved questions:** sickle cell trait is not included by the SNOMED CT concept used for SCD (former OQ-12); the binding strength question is answered by the terminology approach (former OQ-13).
- **Recorded as open questions** for the project team, rather than changed in this version: the publication pathway ([KI-15](issues.html#ki-15)), Must Support of `Condition.evidence.detail` ([OQ-11](issues.html#oq-11)), a search parameter for blood products ([OQ-7](issues.html#oq-7)), retiring the SCD Hydroxyurea Adherence extension ([OQ-28](issues.html#oq-28)), the client display requirement ([OQ-29](issues.html#oq-29)) and the clinical realism of the examples ([OQ-30](issues.html#oq-30)). All open items are on the [Known Issues and Open Questions](issues.html) page.

---

<!-- Planned future versions: to be determined. -->
<!-- TODO: Document roadmap items for future STU or normative versions:
       - Addition of patient-reported outcome (PRO) profiles
       - Genomics profiles (the SCD subtype is currently carried in the diagnosis code)
       - Integration with Da Vinci prior authorization workflows
       - Alignment with FHIR R5 BiologicallyDerivedProduct improvements
       - International extensions (non-US SCD populations)
-->
