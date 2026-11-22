{%- comment -%}
================================================================================
SCOPE AND USAGE PAGE — scope_and_usage.md
{%- endcomment -%}

This page describes what this guide covers: the two use cases, what is out of scope, a scenario for each use case, and how the guide relates to other implementation guides.

### In Scope

This guide supports the two use cases defined by the USCDI+ Sickle Cell Disease (SCD) project:

**Use Case A: SCD Diagnosis.** The SCD Diagnosis use case aims to ensure that all individuals living with SCD are consistently and accurately identified across various care settings using structured data. The [USCDI+ SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) core minimum data element list will facilitate data exchange to meet these two goals:

- All individuals living with SCD have a recorded SCD diagnosis that includes SCD subtype in patient records.
- Improve the identification of individuals living with SCD by accurately sharing documented SCD diagnoses and SCD subtype between systems.

**Use Case B: SCD Emergency Care.** The SCD Emergency Care use case aims to ensure the treatment or interventions received by individuals living with SCD during an acute episode are consistent with care previously received and are adequately captured. The [USCDI+ SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) core minimum data element list will facilitate data exchange to meet this goal:

- All individuals living with SCD receive high-quality care from providers informed by patients' medical histories during acute episodes.

The profiles each use case needs are those that carry a data element on ONC's list for that use case (see [USCDI+ SCD Data Elements](uscdi-plus.html)):

| Use case | USCDI-SCD profiles | US Core profiles used directly |
|---|---|---|
| A: SCD Diagnosis | Patient, Condition Problems and Health Concerns, Condition Encounter Diagnosis, Laboratory Result, MedicationRequest, Medication, CarePlan, Practitioner, PractitionerRole, Location | [US Core Provenance](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-provenance.html), [US Core CareTeam](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-careteam.html) |
| B: SCD Emergency Care | All of those for use case A, plus Encounter, Vital Signs, AllergyIntolerance, Procedure and BiologicallyDerivedProduct | [US Core CareTeam](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-careteam.html), [US Core Goal](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-goal.html), [US Core Immunization](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-immunization.html), [US Core DiagnosticReport for Report and Note Exchange](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-diagnosticreport-note.html), [US Core Observation Clinical Result](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-observation-clinical-result.html), [US Core Observation Screening Assessment](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-observation-screening-assessment.html), [US Core Pediatric BMI for Age](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-pediatric-bmi-for-age.html) |

The Organization and ServiceRequest profiles support the other profiles in both use cases. Organizations are referenced by most clinical resources, and the transfusion order links a transfusion procedure to the blood products used. The US Core profiles in the last column carry USCDI+ SCD data elements without a USCDI-SCD profile; the searches for them are on the [Exchange Workflow](workflow.html#step-3-retrieve-scd-relevant-data) page.

#### Expected Source Systems and New Data Capture

The table lists the systems that typically hold each kind of data. These are typical sources, not requirements. Each organization confirms its own sources when it maps its data (see [Data Element Mapping](data-element-mapping.html)).

| Data | Typical source system |
|---|---|
| Problem list and diagnoses | EHR problem list |
| Laboratory results, including hemoglobin fractionation and antibody screen | Laboratory information system |
| Blood products, processing, antigen match and product age | Blood bank or transfusion service system |
| Medications | EHR orders or pharmacy system |
| Vital signs and encounters | EHR |
| Vaso-occlusive crisis (VOC) episode frequency | Usually not a discrete field. It may need new documentation, or a count derived from encounter records. The extension part for how episodes were counted has no value set binding ([KI-8](issues.html#ki-8)) |
| Newborn screening result | State newborn screening program, or the EHR if the result was recorded there |

Figure 1 shows the data exchange process for these use cases, as tested at a connectathon. <!-- TODO: Name the connectathon and its date. --> When a person with SCD presents to a new provider for care, the provider's system (the Client) queries for the patient's records through a data intermediary. Once a system holding the patient's records (a Server) is found, the record is returned to the provider.

The data intermediary is a third actor, alongside the Client and the Server. It may be a health information exchange or a network, and a hospital's health information exchange may play this role. Its role and requirements are still to be decided ([OQ-1](issues.html#oq-1)); this guide defines no CapabilityStatement for it. See [Conformance Requirements](conformance.html#capabilitystatements).

<figure>
  <a href="uscdi-scd-exchange-process.svg"><img src="uscdi-scd-exchange-process.svg" alt="USCDI-SCD exchange process: the provider's system queries a data intermediary, which queries the systems that may hold the patient's records and returns the record from the system where the patient is found" style="max-width:100%"/></a>
  <figcaption><b>Figure 1: USCDI-SCD Exchange Process</b><br/><a href="uscdi-scd-exchange-process.svg">Open the full-size figure.</a></figcaption>
</figure>

The [Exchange Workflow](workflow.html) page describes each step of this flow in more detail, including the FHIR searches used.

---

### Out of Scope

Use cases other than the two described above are **out of scope** for this version of the guide. In particular, this guide does not define:

- Reporting to public health agencies or registries
- Exports of data for research or quality measurement (such as FHIR Bulk Data)
- Patient-facing applications
- Genomic test results (see [KI-11](issues.html#ki-11))
- Writing data back to the system that holds the patient's record (see [OQ-10](issues.html#oq-10))

---

### Use Case Scenarios

The scenarios below show how each use case plays out for the fictional patient used in this guide's [Examples](examples.html). They describe which information is exchanged; how the care team uses it is a clinical decision.

**Scenario A: SCD Diagnosis.** Maya Johnson, who has HbSS sickle cell disease, sees a new primary care provider.

1. The provider's system locates Maya's records at the hematology center that follows her.
2. It retrieves her problem list, including her SCD diagnosis. The diagnosis code itself identifies the subtype (HbSS), as described on the [Profiles](profiles.html) page.
3. It can also retrieve the laboratory results the diagnosis is based on, such as a hemoglobin fractionation, and her current medications and care plan.
4. Maya's record at the new provider now includes a documented SCD diagnosis with its subtype.

**Scenario B: SCD Emergency Care.** Maya arrives at an emergency department (ED) with a vaso-occlusive pain crisis.

1. The ED system locates Maya's records through a data intermediary (Figure 1).
2. It retrieves her prior history: her SCD diagnosis and subtype, her allergies (including an NSAID intolerance), her prescriptions (hydroxyurea and an iron chelation medication), her chronic transfusion care plan, and her earlier laboratory results and transfusion history.
3. The ED team can see this history when deciding on her care.
4. The ED system records her vital signs (oxygen saturation and pain score), the visit, and its diagnosis (a vaso-occlusive crisis).

In the [Examples](examples.html), the ED visit is on 2024-11-14. The hemoglobin fractionation and the exchange transfusion are dated 2024-11-21, a week after the visit, so they show the kind of records that a later query would return.

The FHIR searches behind Scenario B are shown step by step on the [Exchange Workflow](workflow.html#fhir-interactions-for-scd-emergency-care) page.

---

### Relationship to Other Implementation Guides

USCDI-SCD builds on existing HL7 specifications instead of redefining them. Implementers should be familiar with the following guides and packages.

#### US Core 8.0.1

[US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/) is the foundation of this guide. With one exception, every USCDI-SCD profile is derived from a US Core profile and inherits its constraints, Must Support elements, terminology bindings and search requirements. USCDI-SCD adds SCD-specific constraints and extensions on top of them, and reference value sets that do not add terminology constraints (see [Terminology Approach](terminology.html#terminology-approach)).

The exception is the [USCDI-SCD BiologicallyDerivedProduct](profiles.html#biologically-derived-product-profile) profile, which is based on the FHIR R4 resource.

Systems conforming to USCDI-SCD SHALL also conform to US Core 8.0.1, and the USCDI-SCD CapabilityStatements require support for the corresponding US Core CapabilityStatements. See [Conformance Requirements](conformance.html).

#### USCDI and USCDI+

US Core implements the [United States Core Data for Interoperability (USCDI)](https://www.healthit.gov/isa/united-states-core-data-interoperability-uscdi). USCDI+ extends USCDI with data elements for specific domains and programs. This guide represents the USCDI+ SCD data elements in FHIR, using US Core profiles wherever a USCDI data element already covers the need. For some data elements, ONC's USCDI+ lists also maintain the SCD-relevant values (see [Terminology Approach](terminology.html#terminology-approach)).

#### SMART App Launch

The USCDI-SCD Server CapabilityStatement requires support for [SMART App Launch](http://hl7.org/fhir/smart-app-launch/) (standalone launch and EHR launch) for authorization, consistent with US Core. See [Security and Privacy](security.html).

#### FHIR Extensions Pack

This guide uses the [FHIR Extensions Pack](http://hl7.org/fhir/extensions/) (`hl7.fhir.uv.extensions.r4` 5.1.0) for standard extensions that are not part of the FHIR R4 core specification.

#### Value Set Authority Center (VSAC)

This guide references value sets published by the National Library of Medicine's [Value Set Authority Center](https://vsac.nlm.nih.gov/) through the `us.nlm.vsac` package (version 0.19.0). Value sets defined in this guide are intended for future submission to VSAC.

#### Summary of Dependencies

| Package | Version | Relationship |
|---|---|---|
| hl7.fhir.us.core | 8.0.1 | Parent profiles; conformance foundation |
| hl7.fhir.uv.extensions.r4 | 5.1.0 | Standard extensions |
| us.nlm.vsac | 0.19.0 | Published value sets |

The complete list of package dependencies is shown on the [Home](index.html#dependencies) page.
