This page describes how a USCDI-SCD exchange works, based on what this guide currently defines. The workflow shown in Figure 1 on the [Scope and Usage](scope_and_usage.html#in-scope) page was tested at a connectathon, where several query patterns were tried. Parts of the workflow that have not yet been defined are marked as open items within each step, and are listed with IDs (OQ-n) on the [Known Issues and Open Questions](issues.html) page. Comments on them are especially welcome.

---

### Actors

| Actor | Role | Requirements |
|---|---|---|
| **USCDI-SCD Server** | A system that holds data about people with SCD and returns it in response to queries, such as an EHR or health information exchange | [USCDI-SCD Server CapabilityStatement](CapabilityStatement-uscdi-scd-server.html) |
| **USCDI-SCD Client** | A system used by the provider who needs the patient's SCD information, such as a provider seeing the patient for the first time or an emergency department | [USCDI-SCD Client CapabilityStatement](CapabilityStatement-uscdi-scd-client.html) |
| **Data intermediary** | A system, such as a health information exchange or network, that passes queries and records between the Client and the Servers. A hospital's health information exchange may play this role. Its role is to be decided ([OQ-1](issues.html#oq-1)) | None yet |

---

### Workflow Overview

Both [use cases](scope_and_usage.html#in-scope), SCD Diagnosis and SCD Emergency Care, follow the same pattern, shown in Figure 1 on the [Scope and Usage](scope_and_usage.html#in-scope) page:

1. **Locate the patient.** When the patient presents to a new provider, the Client sends a query to locate the patient's record. The query may find more than one EHR system that holds relevant information.
2. **Authorize access.** The Client connects to the Server using the security requirements in the CapabilityStatements.
3. **Retrieve SCD-relevant data.** Once it has identified the target system or systems, the Client sends an SCD-focused query to retrieve the SCD-relevant resources.
4. **Use the data.** The Client processes and displays the returned data, including Must Support elements and missing data.

Each step is described below.

---

### FHIR Interactions for SCD Emergency Care

Figure 3 shows the FHIR interactions in each step for the SCD Emergency Care use case ([Scenario B](scope_and_usage.html#use-case-scenarios)). The searches are explained in the steps below.

<figure>
  <a href="uscdi-scd-ed-sequence.svg"><img src="uscdi-scd-ed-sequence.svg" alt="Sequence of FHIR interactions between the emergency department system and the system holding the patient's record: locate the patient, authorize access, retrieve SCD-relevant resources, and use the data" style="max-width:100%"/></a>
  <figcaption><b>Figure 3: FHIR Interactions for SCD Emergency Care</b><br/><a href="uscdi-scd-ed-sequence.svg">Open the full-size figure.</a></figcaption>
</figure>

---

### Step 1: Locate the Patient

The Server CapabilityStatement requires servers to support the US Core 8.0.1 Server requirements, which include these Patient searches:

| Search | US Core expectation |
|---|---|
| `GET [base]/Patient?_id=[id]` | SHALL |
| <code>GET [base]/Patient?identifier=[system]&#124;[value]</code> | SHALL |
| `GET [base]/Patient?name=[name]` | SHALL |
| `GET [base]/Patient?name=[name]&birthdate=[date]` | SHALL |

The [Test Data](testing.html) page includes an example search by identifier and its expected response.

<!-- TODO: Define how the client finds which systems hold the patient's records
     (record location), especially when the patient's records may be held by
     more than one EHR system. -->
<!-- TODO: Define the patient matching method (for example, a FHIR search,
     the FHIR Patient/$match operation, or a network record locator) and the
     demographics to use. -->
<!-- TODO: Define what the client does when no patient, or more than one
     candidate patient, is found. -->

**Open items:** how records are located across systems ([OQ-1](issues.html#oq-1)), the patient matching method ([OQ-2](issues.html#oq-2)), and how to handle no match or multiple matches ([OQ-3](issues.html#oq-3)).

---

### Step 2: Authorize Access

Servers are required to support SMART App Launch authorization and TLS 1.2 or higher, and FHIR AuditEvent for access logging. The full list is in [Conformance Requirements](conformance.html#capabilitystatements). See [Security and Privacy](security.html) for guidance on protecting SCD data.

<!-- TODO: Confirm whether SMART App Launch (standalone and EHR launch) fits
     the exchange pattern in the use cases, or whether system-to-system
     authorization between organizations is also needed. Define the SMART
     scopes clients must request. -->

**Open items:** whether the current authorization requirements fit exchange between organizations, which SMART scopes clients need, and how AuditEvent is used for the audit log ([OQ-4](issues.html#oq-4)).

---

### Step 3: Retrieve SCD-Relevant Data

After locating the patient, the Client retrieves the resources needed for its use case. The key profiles for each use case are listed on the [Scope and Usage](scope_and_usage.html#in-scope) page.

The table below lists searches a client can use to retrieve these resources by patient. These are the searches that the US Core 8.0.1 Server CapabilityStatement requires servers to support (SHALL). The USCDI-SCD Server CapabilityStatement imports the US Core Server CapabilityStatement, so the same requirements apply.

| Resource | Searches servers SHALL support | Notes |
|---|---|---|
| Condition | `patient`; `patient` + `category` | Category `problem-list-item` or `encounter-diagnosis` distinguishes the two Condition profiles |
| Observation | `patient` + `category`; `patient` + `category` + `date`; `patient` + `code` | Category `laboratory` for Laboratory Result; `vital-signs` for Vital Signs |
| Encounter | `patient`; `patient` + `date`; `_id` | |
| MedicationRequest | `patient` + `intent`; `patient` + `intent` + `status` | Servers SHOULD also support `_include=MedicationRequest:medication` (US Core) |
| AllergyIntolerance | `patient` | |
| CarePlan | `patient` + `category` | |
| Procedure | `patient`; `patient` + `date` | |
| ServiceRequest | `_id`; `patient`; `patient` + `category`; `patient` + `code`; `patient` + `category` + `authored` | |
| Practitioner | `identifier`; `name` | Referenced from the clinical resources above |
| PractitionerRole | `practitioner`; `specialty` | |
| Organization | `name`; `address` | |
| Location | `name`; `address` | |

Some USCDI+ SCD data elements are carried by US Core profiles that this guide uses directly, without a USCDI-SCD profile (see [USCDI+ SCD Data Elements](uscdi-plus.html)). The US Core 8.0.1 Server CapabilityStatement sets these searches for them:

| Resource (US Core profile) | USCDI+ SCD data elements | Searches servers SHALL support | Searches servers SHOULD support | Notes |
|---|---|---|---|---|
| Provenance ([US Core Provenance](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-provenance.html)) | Author, Author Organization, Author Role, Author Time Stamp | `_revinclude=Provenance:target` on searches of the other clinical resources | | US Core requires `read` of Provenance but no Provenance search. Example: `GET [base]/Condition?patient=[id]&_revinclude=Provenance:target` |
| CareTeam ([US Core CareTeam](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-careteam.html)) | Care Team Member Role | `patient` + `status` | `patient` + `role` | Referenced from `CarePlan.careTeam` |
| Goal ([US Core Goal](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-goal.html)) | Patient Goals | `patient` | `patient` + `lifecycle-status`; `patient` + `description`; `patient` + `target-date` | Referenced from `CarePlan.goal` |
| Immunization ([US Core Immunization](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-immunization.html)) | Immunizations | `patient` | `patient` + `status`; `patient` + `date` | |
| DiagnosticReport ([US Core DiagnosticReport for Report and Note Exchange](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-diagnosticreport-note.html)) | Clinical Test Result/Report, Diagnostic Imaging Report, Diagnostic Imaging Test | `patient`; `patient` + `category`; `patient` + `category` + `date`; `patient` + `code` | `patient` + `code` + `date`; `patient` + `status`; `patient` + `category` + `_lastUpdated` | Category `LP29684-5` (Radiology) for imaging reports |
| Observation ([US Core Observation Clinical Result](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-observation-clinical-result.html)) | Clinical Test, Clinical Test Result/Report, Diagnostic Imaging Test | `patient` + `category`; `patient` + `category` + `date`; `patient` + `code` | `patient` + `code` + `date`; `patient` + `category` + `status`; `patient` + `category` + `_lastUpdated` | Category such as `imaging`, `procedure` or `exam` |
| Observation ([US Core Observation Screening Assessment](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-observation-screening-assessment.html)) | Disability Status, Functional Status, Mental/Cognitive Status | Same as the row above | Same as the row above | Category `disability-status`, `functional-status` or `cognitive-status` |
| Observation ([US Core Pediatric BMI for Age](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-pediatric-bmi-for-age.html)) | BMI Percentile (2 - 20 years) | Same as the row above | Same as the row above | Code LOINC 59576-9, or category `vital-signs` |

US Core sets `_revinclude=Provenance:target` at SHALL for most clinical resources, including Condition, Observation, Encounter, MedicationRequest, AllergyIntolerance, CarePlan, Procedure and ServiceRequest. A client that needs the author of a record can add it to these searches.

**Blood products.** US Core does not cover BiologicallyDerivedProduct, and FHIR R4 has no `patient` search parameter for it, so a client cannot retrieve a patient's blood products with a standard search ([KI-6](issues.html#ki-6)). The CapabilityStatements declare `read` and `search-type` for BiologicallyDerivedProduct at SHOULD, but no search parameters yet ([OQ-7](issues.html#oq-7)).

Worked examples of these searches and their expected responses, using the fictional Maya Johnson test patient, are on the [Test Data](testing.html) page.

<!-- TODO: Define search parameters for BiologicallyDerivedProduct (OQ-7). -->

**Open items:** the definition of an "SCD-focused query" ([OQ-5](issues.html#oq-5)) and of "task-based" ([OQ-6](issues.html#oq-6)), how blood products are retrieved ([OQ-7](issues.html#oq-7)), and any SCD-specific search requirements beyond US Core ([OQ-8](issues.html#oq-8)).


---

### Step 4: Use the Data

Clients are required to process all Must Support elements without error and to handle missing data, and to display SCD-relevant data in human-readable form. The full list is in [Conformance Requirements](conformance.html#capabilitystatements), with the detailed rules under [Must Support](conformance.html#must-support) and [Missing Data](conformance.html#missing-data).

In the SCD Diagnosis use case, documented SCD diagnoses and SCD subtype are shared between systems, so that the patient's record includes an SCD diagnosis with subtype.

**Open item:** whether the SCD Diagnosis use case includes writing data back to another system ([OQ-10](issues.html#oq-10)).
