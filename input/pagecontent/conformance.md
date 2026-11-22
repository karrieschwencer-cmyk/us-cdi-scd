This Implementation Guide builds on [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/). Systems claiming conformance to USCDI-SCD SHALL also conform to US Core 8.0.1. All US Core conformance requirements apply unless this guide explicitly overrides them.

Actors and systems claiming conformance to this guide SHALL implement the requirements in the corresponding [CapabilityStatements](#capabilitystatements).

### Conformance Verbs

This guide uses the conformance verbs defined in the [FHIR conformance rules](http://hl7.org/fhir/R4/conformance-rules.html), which are based on [RFC 2119](https://tools.ietf.org/html/rfc2119) and are also used by US Core:

| Verb | Meaning |
|---|---|
| **SHALL** | An absolute requirement. Not meeting it is a conformance failure. |
| **SHALL NOT** | An absolute prohibition. |
| **SHOULD** | Recommended. There may be valid reasons to deviate, but the full implications should be understood and carefully weighed first. |
| **SHOULD NOT** | Not recommended. There may be valid reasons to do so, but the full implications should be understood and carefully weighed first. |
| **MAY** | Optional. Permitted but not required. |

### Must Support

Elements flagged **Must Support** in the profiles of this guide follow the [US Core 8.0.1 Must Support](http://hl7.org/fhir/us/core/STU8.0.1/must-support.html) definition, with the following requirements:

- Systems SHALL be capable of populating Must Support data elements as specified by the profiles.
- Systems SHALL be capable of processing resource instances containing Must Support data elements without generating an error or causing the application to fail. Systems SHOULD be capable of displaying the data elements for human use or storing them for other purposes.
- When information for a Must Support data element is not present and the reason for its absence is unknown, systems SHALL NOT include the data element in the resource instance, unless the element is required (minimum cardinality of 1). See [Missing Data](#missing-data).
- When accessing USCDI-SCD data, systems SHALL interpret missing data elements within resource instances as data not present.

The same Must Support rules apply to the [USCDI-SCD BiologicallyDerivedProduct](profiles.html#biologically-derived-product-profile) profile, which is based on the FHIR R4 resource.

### Missing Data

Systems SHALL follow the [US Core 8.0.1 Missing Data](http://hl7.org/fhir/us/core/STU8.0.1/general-requirements.html#missing-data) rules, which are the normative statement. In summary:

- If the source system has no data for an element with a minimum cardinality of 0 (including Must Support elements), the element is omitted.
- If the element is mandatory (minimum cardinality of 1 or more), it is still sent:
  - **Non-coded elements:** use the [Data Absent Reason](http://hl7.org/fhir/R4/extension-data-absent-reason.html) extension, with the code `unknown`.
  - **Coded elements with an example, preferred or extensible binding:** if the source system has text but no code, send the text only. Otherwise use the value set's "unknown" concept if it has one, or `unknown` from the [DataAbsentReason code system](http://terminology.hl7.org/CodeSystem/data-absent-reason).
  - **Coded elements with a required binding:** use the value set's "unknown" concept if it has one; otherwise a concept from the value set must be used. US Core lists the status elements that have no "unknown" concept, and how servers respond when they are missing.

### CapabilityStatements

This guide defines two actors, the Client and the Server, and a CapabilityStatement for each. A third actor, the data intermediary, appears in the exchange process but has no CapabilityStatement yet:

| CapabilityStatement | Actor | Description |
|---|---|---|
| [USCDI-SCD Client](CapabilityStatement-uscdi-scd-client.html) | Client (requestor) | Requirements for systems that query for and use SCD data |
| [USCDI-SCD Server](CapabilityStatement-uscdi-scd-server.html) | Server (responder) | Requirements for systems that expose SCD data, such as EHRs and health information exchanges |
| None yet | Data intermediary | A system, such as a health information exchange or network, that passes queries and records between the Client and the Servers that hold the patient's records. A hospital's health information exchange may play this role. Its role and requirements are to be decided ([OQ-1](issues.html#oq-1)). |

**USCDI-SCD Servers SHALL:**

1. Support all US Core 8.0.1 Server requirements.
2. Support the profiles marked SHALL in the [Profile Conformance Summary](#profile-conformance-summary), using the interactions and searches in the imported US Core Server CapabilityStatement.
3. Support SMART App Launch (standalone launch and EHR launch).
4. Use TLS 1.2 or higher for all connections.
5. Support FHIR AuditEvent for access logging.

**USCDI-SCD Clients SHALL:**

1. Support all US Core 8.0.1 Client requirements.
2. Be capable of requesting and processing the USCDI-SCD profiles marked SHALL in the [Profile Conformance Summary](#profile-conformance-summary).
3. Process all Must Support elements in USCDI-SCD profiles without error.
4. Handle missing data. See Missing Data above.
5. Display SCD-relevant clinical data in human-readable form. Whether this should be a SHOULD, because it cannot be tested, is an open question ([OQ-29](issues.html#oq-29)).

**USCDI-SCD Clients SHOULD:**

1. Support the USCDI-SCD profiles marked SHOULD in the [Profile Conformance Summary](#profile-conformance-summary).

### Profile Conformance Summary

The table below summarizes the expected level of support for each profile. These levels match the per-resource expectations in the CapabilityStatements. Clients SHALL support the profiles at the core of the SCD use cases (the patient, diagnoses, encounters, observations, procedures, allergies and prescriptions), and SHOULD support the supporting profiles.

This guide defines one set of client levels for both use cases, because a client may serve either one. Every SCD Diagnosis data element is also on the SCD Emergency Care list, except the four Author data elements, which US Core Provenance carries (see [USCDI+ SCD Data Elements](uscdi-plus.html)). Whether separate client levels are needed for each use case is an open question ([OQ-26](issues.html#oq-26)).

| Profile | Server | Client |
|---|---|---|
| [USCDI-SCD Patient](StructureDefinition-uscdi-scd-patient.html) | SHALL | SHALL |
| [USCDI-SCD Practitioner](StructureDefinition-uscdi-scd-practitioner.html) | SHALL | SHOULD |
| [USCDI-SCD PractitionerRole](StructureDefinition-uscdi-scd-practitionerrole.html) | SHALL | SHOULD |
| [USCDI-SCD Organization](StructureDefinition-uscdi-scd-organization.html) | SHALL | SHOULD |
| [USCDI-SCD Location](StructureDefinition-uscdi-scd-location.html) | SHALL | SHOULD |
| [USCDI-SCD Encounter](StructureDefinition-uscdi-scd-encounter.html) | SHALL | SHALL |
| [USCDI-SCD Condition Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html) | SHALL | SHALL |
| [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) | SHALL | SHALL |
| [USCDI-SCD AllergyIntolerance](StructureDefinition-uscdi-scd-allergyintolerance.html) | SHALL | SHALL |
| [USCDI-SCD CarePlan](StructureDefinition-uscdi-scd-careplan.html) | SHALL | SHOULD |
| [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html) | SHALL | SHOULD |
| [USCDI-SCD Medication](StructureDefinition-uscdi-scd-medication.html) | SHALL | SHOULD |
| [USCDI-SCD MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html) | SHALL | SHALL |
| [USCDI-SCD Procedure](StructureDefinition-uscdi-scd-procedure.html) | SHALL | SHALL |
| [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html) | SHALL | SHALL |
| [USCDI-SCD Vital Signs](StructureDefinition-uscdi-scd-vital-signs.html) | SHALL | SHALL |
| [USCDI-SCD BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) | SHOULD | SHOULD |

BiologicallyDerivedProduct support is recommended for systems that manage blood product transfusion records for people with SCD. Systems that do not manage transfusion records MAY omit it.

### What This Guide Adds to US Core

Systems that already conform to US Core 8.0.1 need to add the following to conform to this guide. The table lists, for each profile, the elements that are Must Support in this guide but not in the US Core parent, and the extensions defined by this guide. Reference targets constrained to USCDI-SCD profiles are listed under [Reference Targets](#reference-targets) and shown on each profile page.

| Profile | Must Support added beyond US Core | Extensions from this guide |
|---|---|---|
| [USCDI-SCD Patient](StructureDefinition-uscdi-scd-patient.html) | race, ethnicity, telecom, communication | SCD Newborn Screen Reference |
| [USCDI-SCD Encounter](StructureDefinition-uscdi-scd-encounter.html) | diagnosis (condition, use) | |
| [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) | recorder, asserter, evidence (id) | SCD Vaso-Occlusive Crisis Frequency (Must Support), SCD Newborn Screen Reference |
| [USCDI-SCD Condition Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html) | clinicalStatus, verificationStatus, onset, abatement, evidence (id) | |
| [USCDI-SCD AllergyIntolerance](StructureDefinition-uscdi-scd-allergyintolerance.html) | type, category, criticality, onset, reaction.substance, reaction.severity | |
| [USCDI-SCD CarePlan](StructureDefinition-uscdi-scd-careplan.html) | period, author, careTeam, addresses, goal, activity (reference, detail.status, detail.description) | |
| [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html) | performer, reasonCode, reasonReference | |
| [USCDI-SCD MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html) | reasonCode, reasonReference | SCD Iron Chelation Indication (Must Support) |
| [USCDI-SCD Procedure](StructureDefinition-uscdi-scd-procedure.html) | performer (actor), reasonCode, reasonReference, usedReference | SCD Transfusion Red Cell Antigen Match |
| [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html) | referenceRange.low, referenceRange.high, component (code, value) | |
| [USCDI-SCD BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) | Not in US Core: the whole profile is new (productCategory, productCode, status, request, collection, processing, storage) | SCD Transfusion Red Cell Antigen Match and SCD Blood Product Age at Transfusion (both Must Support) |

The USCDI-SCD Practitioner, PractitionerRole, Organization, Location, Medication and Vital Signs profiles add no Must Support elements to US Core. The Practitioner, PractitionerRole, Organization, Location and Medication profiles add no constraints; Medication adds only a non-constraining reference binding on `Medication.code`. They exist so that the other profiles have a consistent set of USCDI-SCD reference targets ([KI-9](issues.html#ki-9)).

The [SCD Hydroxyurea Adherence](StructureDefinition-scd-hydroxyurea-adherence.html) extension is not used by any profile ([KI-7](issues.html#ki-7)). Whether to replace it with the US Core Medication Adherence extension is an open question ([OQ-28](issues.html#oq-28)).

Whether each added Must Support element should be kept is an open question ([OQ-19](issues.html#oq-19)). The server requirements for TLS and the audit log in the [Server CapabilityStatement](CapabilityStatement-uscdi-scd-server.html) documentation are not yet defined in testable terms ([OQ-4](issues.html#oq-4)).

### Reference Targets

The USCDI-SCD profiles narrow many references to USCDI-SCD profiles. This means some data that is valid under US Core 8.0.1 is not valid under this guide. The table lists the targets that US Core allows but this guide does not. Whether to keep this narrowing is an open question ([OQ-21](issues.html#oq-21)).

| Profile and element | Targets allowed by US Core but not by this guide |
|---|---|
| USCDI-SCD Procedure: `Procedure.performer.actor` | Patient, RelatedPerson, Device |
| USCDI-SCD Procedure: `Procedure.reasonReference` | Observation, Procedure, DiagnosticReport, DocumentReference |
| USCDI-SCD Procedure: `Procedure.usedReference` | Substance |
| USCDI-SCD ServiceRequest: `ServiceRequest.requester` | Organization, Patient, RelatedPerson, Device |
| USCDI-SCD ServiceRequest: `ServiceRequest.performer` | CareTeam, HealthcareService, Patient, Device, RelatedPerson |
| USCDI-SCD ServiceRequest: `ServiceRequest.reasonReference` | Observation, DiagnosticReport, DocumentReference |
| USCDI-SCD ServiceRequest: `ServiceRequest.subject` | Group, Location, Device |
| USCDI-SCD MedicationRequest: `MedicationRequest.reasonReference` | Observations other than laboratory results (such as vital signs) |
| USCDI-SCD Encounter: `Encounter.participant.individual` | RelatedPerson |
| USCDI-SCD Encounter: `Encounter.reasonReference` | Observations other than laboratory results (such as vital signs), ImmunizationRecommendation |
| USCDI-SCD Laboratory Result: `Observation.subject` | Group, Device, Location |
| USCDI-SCD CarePlan: `CarePlan.author` | Patient, RelatedPerson, Device, CareTeam |
| USCDI-SCD CarePlan: `CarePlan.addresses` | Conditions other than USCDI-SCD Condition Problems and Health Concerns, such as encounter diagnoses |

In addition, every profile with a patient reference narrows it to USCDI-SCD Patient, and selected references (such as subject, encounter, performer, reason, author, location, service provider and medication) are narrowed to the matching USCDI-SCD profiles. Other references, for example `Condition.recorder`, `Observation.performer` and `Procedure.location`, allow the same targets as US Core.
