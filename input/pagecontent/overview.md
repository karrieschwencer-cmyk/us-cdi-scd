This page gives an overview of the guide: the information model, a summary of every profile, and the conventions used throughout. The guide represents the United States Core Data for Interoperability Plus (USCDI+) Sickle Cell Disease (SCD) data elements in FHIR. It was developed as part of the USCDI+ SCD project of the Office of the National Coordinator for Health Information Technology (ONC), which supports the exchange of data for the care of people with SCD. The project has also produced a landscape analysis and data element lists. The guide addresses two related use cases; see [Scope and Usage](scope_and_usage.html).

### Information Model

Figure 2 shows the information exchanged in the two use cases addressed by this guide.

- Each box is an information concept, and generally corresponds to one FHIR resource in this guide. Each resource contains several related data elements.
- Each line is a relationship between two concepts. Read the label from the start of the line to the arrowhead: for example, a Condition / Problem *is evidenced by* a Lab Result.
- The model does not show cardinality, and the FHIR references between resources may point in either direction.

<figure>
  <a href="uscdi-scd-info-model.svg"><img src="uscdi-scd-info-model.svg" alt="USCDI-SCD information model: concepts such as Patient, Encounter, Condition, Lab Result, Order and Care Plan, and the relationships between them" style="max-width:100%"/></a>
  <figcaption><b>Figure 2: USCDI-SCD Information Model</b><br/><a href="uscdi-scd-info-model.svg">Open the full-size figure.</a></figcaption>
</figure>

**Key to Figure 2.** Each box in the figure is represented by these profiles:

| Box in Figure 2 | Profile |
|---|---|
| Patient | [USCDI-SCD Patient](StructureDefinition-uscdi-scd-patient.html) |
| Practitioner | [USCDI-SCD Practitioner](StructureDefinition-uscdi-scd-practitioner.html) and [USCDI-SCD PractitionerRole](StructureDefinition-uscdi-scd-practitionerrole.html) |
| Facility | [USCDI-SCD Location](StructureDefinition-uscdi-scd-location.html) |
| Encounter | [USCDI-SCD Encounter](StructureDefinition-uscdi-scd-encounter.html) |
| Condition / Problem | [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) |
| Encounter Diagnosis | [USCDI-SCD Condition Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html) |
| Allergy | [USCDI-SCD AllergyIntolerance](StructureDefinition-uscdi-scd-allergyintolerance.html) |
| Lab Test | The test code (`Observation.code`) in [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html) |
| Lab Result | [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html) |
| Order | [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html) |
| Care Plan | [USCDI-SCD CarePlan](StructureDefinition-uscdi-scd-careplan.html) |
| Procedure | [USCDI-SCD Procedure](StructureDefinition-uscdi-scd-procedure.html) |
| Medication | [USCDI-SCD MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html) and [USCDI-SCD Medication](StructureDefinition-uscdi-scd-medication.html) |
| Biologically Derived Product | [USCDI-SCD BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) |

The [USCDI+ SCD Data Elements](uscdi-plus.html) page maps each data element in ONC's Version 1 USCDI+ SCD data element lists to the profile and element that represents it, and lists the data elements not yet covered.

---

### Profile Summary

The following profiles are defined in this guide:

| Profile | Base Resource | Parent Profile | Purpose |
|---|---|---|---|
| [USCDI-SCD Patient](StructureDefinition-uscdi-scd-patient.html) | Patient | US Core Patient | Patient demographics, including race, ethnicity and preferred language |
| [USCDI-SCD Practitioner](StructureDefinition-uscdi-scd-practitioner.html) | Practitioner | US Core Practitioner | SCD care team providers |
| [USCDI-SCD PractitionerRole](StructureDefinition-uscdi-scd-practitionerrole.html) | PractitionerRole | US Core PractitionerRole | Provider roles and affiliations |
| [USCDI-SCD Organization](StructureDefinition-uscdi-scd-organization.html) | Organization | US Core Organization | Care organizations |
| [USCDI-SCD Location](StructureDefinition-uscdi-scd-location.html) | Location | US Core Location | Care delivery locations |
| [USCDI-SCD Encounter](StructureDefinition-uscdi-scd-encounter.html) | Encounter | US Core Encounter | SCD-related encounters |
| [USCDI-SCD Condition Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html) | Condition | US Core Condition Encounter Diagnosis | Acute diagnoses, such as vaso-occlusive crisis (VOC) and acute chest syndrome (ACS) |
| [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) | Condition | US Core Condition Problems and Health Concerns | Chronic SCD problem list |
| [USCDI-SCD AllergyIntolerance](StructureDefinition-uscdi-scd-allergyintolerance.html) | AllergyIntolerance | US Core Allergy Intolerance | Drug/transfusion allergies |
| [USCDI-SCD CarePlan](StructureDefinition-uscdi-scd-careplan.html) | CarePlan | US Core CarePlan | SCD disease management care plans |
| [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html) | ServiceRequest | US Core ServiceRequest | Referrals and orders |
| [USCDI-SCD Medication](StructureDefinition-uscdi-scd-medication.html) | Medication | US Core Medication | SCD medications |
| [USCDI-SCD MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html) | MedicationRequest | US Core MedicationRequest | SCD prescriptions (hydroxyurea, iron chelation) |
| [USCDI-SCD Procedure](StructureDefinition-uscdi-scd-procedure.html) | Procedure | US Core Procedure | Transfusions, hematopoietic stem cell transplantation (HSCT), phlebotomy |
| [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html) | Observation | US Core Laboratory Result Observation | Complete blood count (CBC), hemoglobin (Hgb) fractionation, ferritin |
| [USCDI-SCD Vital Signs](StructureDefinition-uscdi-scd-vital-signs.html) | Observation | US Core Vital Signs | Oxygen saturation (SpO2), pain score, blood pressure, temperature |
| [USCDI-SCD BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) | BiologicallyDerivedProduct | FHIR 4.0.1 Base | Blood products used in SCD care |

---

### Conventions

The following conventions apply throughout this guide.

- **Naming.** Profiles are titled "USCDI-SCD [Resource]" (for example, USCDI-SCD Patient) and extensions, value sets and code systems are titled "SCD [Concept]" (for example, SCD Newborn Screen Reference and SCD Diagnosis Value Set). All artifacts defined by this guide have canonical URLs beginning with `http://hl7.org/fhir/us/uscdi-scd/`.
- **Profile basis.** Every profile extends a [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/) profile except USCDI-SCD BiologicallyDerivedProduct, which is based on the FHIR R4 resource because US Core has no BiologicallyDerivedProduct profile (see [Profiles](profiles.html#biologically-derived-product-profile)).
- **References.** In every clinical profile, the reference to the patient is constrained to the USCDI-SCD Patient profile, and many other references (such as encounter, reason and performer) are constrained to the corresponding USCDI-SCD profiles. This rejects some data that is valid under US Core; see [Reference Targets](conformance.html#reference-targets). The administrative profiles (Practitioner, PractitionerRole, Organization and Location) and USCDI-SCD Medication add no constraints of their own. They exist so that the other profiles have a consistent set of USCDI-SCD reference targets ([KI-9](issues.html#ki-9)).
- **Must Support.** Elements marked with an **S** in a profile are Must Support. See [Must Support](conformance.html#must-support).
- **Conformance verbs.** SHALL, SHOULD and MAY have the meanings defined in [Conformance Verbs](conformance.html#conformance-verbs).
- **Terminology bindings.** This guide does not add terminology constraints beyond US Core. Its value sets are reference lists. Five are shown as Additional Bindings with the purpose **starter**, which do not constrain the element; three are bound with **example** strength; the ninth, SCD Vital Signs, is a reference list not linked to a profile. The SCD-relevant values are maintained in ONC's USCDI+ SCD data element lists. See [Terminology Approach](terminology.html#terminology-approach).
- **Code systems.** Following the US Core bindings, diagnoses use SNOMED CT or ICD-10-CM (the examples include both), procedures use SNOMED CT or CPT, laboratory results and vital signs use LOINC, and medications use RxNorm.
- **Examples.** All examples follow a single fictional patient. See [Examples](examples.html).
- **Draft status.** This is a draft guide. Known limitations and unresolved questions are listed on the [Known Issues and Open Questions](issues.html) page.
