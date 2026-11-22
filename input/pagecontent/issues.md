{%- comment -%}
================================================================================
KNOWN ISSUES AND OPEN QUESTIONS PAGE — issues.md
================================================================================
Keep this page in sync with the TODO comments in the source. When an item is
resolved, remove it here, add its ID to Retired IDs, and record the change on
the Change Log page.
Items use stable IDs (KI-n, OQ-n) so that other pages can refer to them; do not
renumber existing items. Each item starts with an anchor (for example,
<a id="oq-21"></a>) so that other pages can link to issues.html#oq-21.
{%- endcomment -%}

This is a draft guide. This page lists its known limitations (KI) and the questions that are still open (OQ), so that implementers can plan around them. Each item notes what it affects. To comment on any item, see [How to Give Feedback](audience.html#how-to-give-feedback).

### Summary

There are 15 known issues and 27 open questions. The Impact column groups them:

- **Blocks go-live:** must be settled before systems in different organizations can exchange data.
- **Affects effort:** changes what a system has to build or support.
- **Terminology only:** affects codes and value sets, not system design.
- **Process:** affects documentation, testing or publication, not systems.

| ID | Title | Impact | Related page |
|---|---|---|---|
| [KI-1](#ki-1) | No SNOMED CT codes for two stem cell products | Terminology only | [Terminology](terminology.html) |
| [KI-2](#ki-2) | No OIDs yet | Process | [Terminology](terminology.html) |
| [KI-3](#ki-3) | ISBT 128 not yet included | Terminology only | [Terminology](terminology.html) |
| [KI-4](#ki-4) | Value sets are incomplete reference lists | Terminology only | [Terminology Approach](terminology.html#terminology-approach) |
| [KI-5](#ki-5) | No direct link from a blood product to the patient or the procedure | Affects effort | [Profiles](profiles.html#biologically-derived-product-profile) |
| [KI-6](#ki-6) | No standard patient search for blood products | Affects effort | [Exchange Workflow](workflow.html#step-3-retrieve-scd-relevant-data) |
| [KI-7](#ki-7) | One extension is not used by any profile | Affects effort | [Extensions](extensions.html) |
| [KI-8](#ki-8) | Unbound extension parts | Terminology only | [Extensions](extensions.html) |
| [KI-9](#ki-9) | Several profiles add few or no constraints | Affects effort | [Reference Targets](conformance.html#reference-targets) |
| [KI-10](#ki-10) | Must Support added beyond US Core | Affects effort | [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core) |
| [KI-11](#ki-11) | Data elements not fully covered | Affects effort | [USCDI+ SCD Data Elements](uscdi-plus.html#gaps-and-partial-coverage) |
| [KI-12](#ki-12) | One test patient | Process | [Test Data](testing.html) |
| [KI-13](#ki-13) | HL7 Jira specification not yet registered | Process | [How to Give Feedback](audience.html#how-to-give-feedback) |
| [KI-14](#ki-14) | Dependency versions | Affects effort | [Dependencies](index.html#dependencies) |
| [KI-15](#ki-15) | Publication pathway not yet confirmed | Process | [Home](index.html) |
| [OQ-1](#oq-1) | Record location | Blocks go-live | [Exchange Workflow, Step 1](workflow.html#step-1-locate-the-patient) |
| [OQ-2](#oq-2) | Patient matching | Blocks go-live | [Exchange Workflow, Step 1](workflow.html#step-1-locate-the-patient) |
| [OQ-3](#oq-3) | No match or multiple matches | Blocks go-live | [Exchange Workflow, Step 1](workflow.html#step-1-locate-the-patient) |
| [OQ-4](#oq-4) | Authorization and security | Blocks go-live | [Exchange Workflow, Step 2](workflow.html#step-2-authorize-access) |
| [OQ-5](#oq-5) | SCD-focused query | Affects effort | [Exchange Workflow, Step 3](workflow.html#step-3-retrieve-scd-relevant-data) |
| [OQ-6](#oq-6) | "Task-based" query | Affects effort | [Exchange Workflow, Step 3](workflow.html#step-3-retrieve-scd-relevant-data) |
| [OQ-7](#oq-7) | Blood product retrieval | Affects effort | [Exchange Workflow, Step 3](workflow.html#step-3-retrieve-scd-relevant-data) |
| [OQ-8](#oq-8) | SCD-specific search requirements | Affects effort | [Exchange Workflow, Step 3](workflow.html#step-3-retrieve-scd-relevant-data) |
| [OQ-9](#oq-9) | Client requirements | Affects effort | [CapabilityStatements](conformance.html#capabilitystatements) |
| [OQ-10](#oq-10) | Write-back | Affects effort | [Exchange Workflow, Step 4](workflow.html#step-4-use-the-data) |
| [OQ-11](#oq-11) | SCD subtype and evidence | Terminology only | [Profiles](profiles.html#clinical-condition-profiles) |
| [OQ-14](#oq-14) | Observation categories | Terminology only | [Terminology](terminology.html) |
| [OQ-15](#oq-15) | Encounter reason | Terminology only | [Terminology](terminology.html) |
| [OQ-16](#oq-16) | Acute complication codes | Terminology only | [Terminology](terminology.html) |
| [OQ-17](#oq-17) | Estimated GFR code | Terminology only | [Terminology](terminology.html) |
| [OQ-18](#oq-18) | Blood product processing codes | Terminology only | [Terminology](terminology.html) |
| [OQ-19](#oq-19) | Must Support scope | Affects effort | [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core) |
| [OQ-20](#oq-20) | Transfusion links | Affects effort | [Extensions](extensions.html#transfusion) |
| [OQ-21](#oq-21) | Reference targets | Affects effort | [Reference Targets](conformance.html#reference-targets) |
| [OQ-22](#oq-22) | Pain score | Affects effort | [Profiles](profiles.html#observation-profiles) |
| [OQ-23](#oq-23) | Connectathon | Process | [Scope and Usage](scope_and_usage.html#in-scope) |
| [OQ-25](#oq-25) | Future extensions | Process | [Extensions](extensions.html) |
| [OQ-26](#oq-26) | Client conformance levels per use case | Affects effort | [Profile Conformance Summary](conformance.html#profile-conformance-summary) |
| [OQ-27](#oq-27) | Content beyond the Version 1 lists | Affects effort | [USCDI+ SCD Data Elements](uscdi-plus.html#elements-in-this-guide-beyond-the-version-1-lists) |
| [OQ-28](#oq-28) | Hydroxyurea adherence | Affects effort | [Extensions](extensions.html) |
| [OQ-29](#oq-29) | Client display requirement | Affects effort | [CapabilityStatements](conformance.html#capabilitystatements) |
| [OQ-30](#oq-30) | Clinical realism of the examples | Process | [Examples](examples.html) |

**Items that may be removed.** Some requirements of this version may be removed in a later one. They are still required to conform to this version. A hospital planning its work may choose to schedule them last:

- The Must Support elements that this guide adds beyond US Core ([OQ-19](#oq-19)). They are listed under [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core).
- `Procedure.usedReference`, which is Must Support ([OQ-20](#oq-20)).
- The content beyond ONC's Version 1 lists ([OQ-27](#oq-27)): the SCD Vaso-Occlusive Crisis Frequency extension (Must Support on USCDI-SCD Condition Problems and Health Concerns), the SCD Iron Chelation Indication extension (Must Support on USCDI-SCD MedicationRequest), the SCD Blood Product Age at Transfusion extension (Must Support on USCDI-SCD BiologicallyDerivedProduct), the SCD Newborn Screen Reference extension and the USCDI-SCD ServiceRequest profile.

**Retired IDs.** These IDs are no longer used, and will not be reused. See the [Change Log](changes.html).

- **OQ-12.** The question whether SNOMED CT 417357006 (Sickling disorder due to hemoglobin S) also covers sickle cell trait was resolved: a subsumption check on tx.fhir.org (SNOMED CT International Edition 20260701) found that it does not include 16402000 (Sickle cell trait).
- **OQ-13.** The question on binding strength was resolved by the [Terminology Approach](terminology.html#terminology-approach).
- **OQ-24.** A separate review of the example scenario by a hematologist is not planned. Clinical statements in this guide are cited to the sources on the [References](references.html) page.

---

### Known Issues

#### Terminology

- <a id="ki-1"></a>**KI-1. No SNOMED CT codes for two stem cell products.** SNOMED CT has no product concept for hematopoietic progenitor cells collected from bone marrow or cord blood, so the [SCD Blood Product Type Value Set](ValueSet-scd-blood-product-type-vs.html) lists only stem cells collected by apheresis (1351653002). Codes for the other two products are planned with ISBT 128 ([KI-3](#ki-3)).
- <a id="ki-2"></a>**KI-2. No OIDs yet.** The nine value sets and two code systems defined in this guide do not yet have OIDs. They are intended for future submission to [VSAC](https://vsac.nlm.nih.gov/), which assigns OIDs.
- <a id="ki-3"></a>**KI-3. ISBT 128 not yet included.** Blood products and red cell antigens are coded with SNOMED CT and local codes. ISBT 128 codes are planned for a future version; the FHIR code system URI to use for ISBT 128 has not yet been confirmed.
- <a id="ki-4"></a>**KI-4. Value sets are incomplete reference lists.** The value sets list commonly used codes and do not claim complete coverage. For example, the [SCD Medication Value Set](ValueSet-scd-medication-vs.html) does not include analgesics, and the [SCD Procedure Value Set](ValueSet-scd-procedure-vs.html) does not include CPT codes. The value sets add no constraints: five are shown as Additional Bindings with the purpose open, where the US Core binding applies, and three are bound with example strength; the ninth, SCD Vital Signs, is not linked to a profile. Codes outside these lists are valid. The SCD-relevant values for ten data elements are maintained in ONC's USCDI+ SCD lists, not in this guide. See [Terminology Approach](terminology.html#terminology-approach).

#### FHIR R4 BiologicallyDerivedProduct

- <a id="ki-5"></a>**KI-5. No direct link to the patient or the procedure.** In FHIR R4, BiologicallyDerivedProduct has no element that references the patient who received it, and `Procedure.usedReference` cannot reference it. This guide links products to patients and procedures through the transfusion order (ServiceRequest). See the [USCDI-SCD BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html) profile.
- <a id="ki-6"></a>**KI-6. No standard patient search.** FHIR R4 defines no `patient` search parameter for BiologicallyDerivedProduct, so a client cannot retrieve a patient's blood products with a standard search. The CapabilityStatements declare `read` and `search-type` for BiologicallyDerivedProduct, but no search parameters. See [OQ-7](#oq-7).

#### Profiles and Extensions

- <a id="ki-7"></a>**KI-7. One extension is not used by any profile.** The [SCD Hydroxyurea Adherence](StructureDefinition-scd-hydroxyurea-adherence.html) extension is defined for use on Observation or MedicationStatement, but no profile in this guide includes it, and its parts have no value set bindings. An [example](MedicationStatement-maya-johnson-hydroxyurea-adherence.html) shows it on a FHIR R4 MedicationStatement. See [OQ-28](#oq-28).
- <a id="ki-8"></a>**KI-8. Unbound extension parts.** The `indicationCode` and `triggerMeasurement` parts of the [SCD Iron Chelation Indication](StructureDefinition-scd-iron-chelation-indication.html) extension and the `measurementMethod` part of the [SCD Vaso-Occlusive Crisis Frequency](StructureDefinition-scd-voc-frequency.html) extension have no value set binding.
- <a id="ki-9"></a>**KI-9. Several profiles add few or no constraints.** The USCDI-SCD Practitioner, PractitionerRole, Organization, Location and Medication profiles add no constraints to their US Core parents, and USCDI-SCD Vital Signs only constrains its subject to the USCDI-SCD Patient profile. They exist so that the other profiles have a consistent set of USCDI-SCD reference targets. See [Reference Targets](conformance.html#reference-targets) and [OQ-21](#oq-21).
- <a id="ki-10"></a>**KI-10. Must Support added beyond US Core.** Several profiles flag elements as Must Support that US Core marks only as additional USCDI requirements, or not at all (for example, telecom and communication on Patient, and type, category and criticality on AllergyIntolerance). Systems must support these elements to conform to this guide, even if they already conform to US Core. The [Data Element Mapping](data-element-mapping.html) page lists every Must Support element. See [OQ-19](#oq-19).

#### USCDI+ SCD Coverage

- <a id="ki-11"></a>**KI-11. Data elements not fully covered.** Of the 75 data elements in ONC's Version 1 USCDI+ SCD lists, 55 are represented in this guide's profiles, 15 in US Core profiles used directly, 3 partly and 2 not yet. The two not yet represented are Variant Interpretation and Blood Transfusion Product Blood Type. The three partly represented are Blood Genotype, Blood Transfusion Product Antibody and Blood Transfusion Product Antigen. See [USCDI+ SCD Data Elements](uscdi-plus.html#gaps-and-partial-coverage).

#### Test Data and Publication

- <a id="ki-12"></a>**KI-12. One test patient.** The [Test Data](testing.html) covers a single fictional patient, whose scenario follows the SCD Emergency Care use case. Test data for the SCD Diagnosis use case, other SCD subtypes and ages, and missing-data cases is planned.
- <a id="ki-13"></a>**KI-13. HL7 Jira specification not yet registered.** The HL7 Jira specification for this guide has not yet been created, so change requests made with the **Propose a change** link at the bottom of each page may not be associated with this guide. See [How to Give Feedback](audience.html#how-to-give-feedback).
- <a id="ki-14"></a>**KI-14. Dependency versions.** This guide is built on US Core 8.0.1 and the FHIR Extensions Pack 5.1.0 (R4). Newer versions of both packages, including US Core 9.0.0, have been published.
- <a id="ki-15"></a>**KI-15. Publication pathway not yet confirmed.** The guide uses an HL7 canonical URL (`http://hl7.org/fhir/us/uscdi-scd`), the package id `hl7.fhir.us.uscdi-scd` and HL7 International / Public Health as publisher, while it is developed under the FHIR Community Process. The publication pathway is to be confirmed with the FHIR Management Group and the Public Health Work Group co-chairs. *Affects: canonical URL, package id, publisher and sponsorship statements.*

---

### Open Questions

#### Exchange Workflow

Most of these questions are also noted on the [Exchange Workflow](workflow.html) page, in the step they affect.

- <a id="oq-1"></a>**OQ-1. Record location.** How does the client find which systems hold the patient's records, especially when more than one EHR system holds them? What role does a data intermediary, such as a health information exchange, play? *Affects: exchange between organizations.*
- <a id="oq-2"></a>**OQ-2. Patient matching.** Which matching method should be used (for example, a FHIR search, the FHIR `Patient/$match` operation or a network record locator), and which demographics? *Affects: exchange between organizations.*
- <a id="oq-3"></a>**OQ-3. No match or multiple matches.** What should the client do when no patient, or more than one candidate patient, is found? *Affects: exchange between organizations; patient safety.*
- <a id="oq-4"></a>**OQ-4. Authorization and security.** Does SMART App Launch (standalone and EHR launch) fit exchange between organizations, or is system-to-system authorization also needed? Which SMART scopes must clients request? The server requirements for TLS and for an audit log of access (including how AuditEvent is used) are stated in the CapabilityStatement documentation but are not yet defined in testable terms. *Affects: go-live between organizations; conformance testing.*
- <a id="oq-5"></a>**OQ-5. SCD-focused query.** Which resources and searches make up an "SCD-focused query" for each use case, and are results narrowed (for example, by code or date range)? *Affects: client design.*
- <a id="oq-6"></a>**OQ-6. "Task-based" query.** What does "task-based" mean in the description of the query (for example, whether the FHIR Task resource is used)? *Affects: client and server design.*
- <a id="oq-7"></a>**OQ-7. Blood product retrieval.** How should a client retrieve a patient's blood products ([KI-6](#ki-6))? One option is a search parameter on `BiologicallyDerivedProduct.request`, used with `_revinclude=BiologicallyDerivedProduct:request` on a ServiceRequest search for the patient; another is a search parameter that finds blood products by patient. *Affects: transfusion data in the Emergency Care use case; server and client design.*
- <a id="oq-8"></a>**OQ-8. SCD-specific search requirements.** Are any search parameters needed beyond those US Core requires? *Affects: server design.*
- <a id="oq-9"></a>**OQ-9. Client requirements.** Are there SCD-specific requirements for clients beyond those in the [Client CapabilityStatement](CapabilityStatement-uscdi-scd-client.html)? *Affects: client design.*
- <a id="oq-10"></a>**OQ-10. Write-back.** In the SCD Diagnosis use case, is a shared SCD diagnosis only recorded in the receiving system, or is it also sent back to another system? *Affects: SCD Diagnosis use case scope.*

#### Terminology

- <a id="oq-11"></a>**OQ-11. SCD subtype and evidence.** Should the SCD subtype continue to be carried only in the diagnosis code (`Condition.code`) rather than in a separate extension? Should `Condition.evidence.detail` (the link to supporting laboratory results) be Must Support, rather than `evidence.id`? *Affects: SCD Diagnosis use case.*
- <a id="oq-14"></a>**OQ-14. Observation categories.** Should the [SCD Observation Category](CodeSystem-scd-observation-category-cs.html) codes be aligned with LOINC Part codes or US Core observation categories, or submitted to HL7 Terminology (THO) or LOINC? Some codes also overlap with the HL7 v2 diagnostic service section codes (Table 0074) `HM` (Hematology) and `BLB` (Blood Bank). Should the codes use one naming pattern (two of the five codes start with `scd-`)? `scd-pain-assessment` also overlaps the HL7 `survey` category (see [OQ-22](#oq-22)). *Affects: terminology; searching observations by category.*
- <a id="oq-15"></a>**OQ-15. Encounter reason.** Should `Encounter.reasonCode` be bound to an SCD encounter reason value set? *Affects: terminology only.*
- <a id="oq-16"></a>**OQ-16. Acute complication codes.** The [SCD Acute Complication Value Set](ValueSet-scd-acute-complication-vs.html) now lists every billable ICD-10-CM D57 "with crisis" code, and general codes that are not specific to SCD (stroke, sepsis, acute kidney injury, osteomyelitis and delayed hemolytic transfusion reaction). Should it list only SCD-specific complications? *Affects: terminology only.*
- <a id="oq-17"></a>**OQ-17. Estimated GFR code.** The [SCD Laboratory Panel Value Set](ValueSet-scd-laboratory-panel-vs.html) lists LOINC 62238-1 (CKD-EPI eGFR) and 98979-8 (CKD-EPI 2021 eGFR, which does not use race). Should 62238-1 be removed? *Affects: terminology only.*
- <a id="oq-18"></a>**OQ-18. Blood product processing codes.** Some codes in the [SCD Blood Product Processing](CodeSystem-scd-blood-product-processing-cs.html) code system overlap with other content: `leukoreduced` and `irradiated` correspond to SNOMED CT product concepts already in the SCD Blood Product Type value set (126251004 Leukocyte reduced red blood cells, human; 126256009 Red blood cells, human, irradiated), and `cmv-negative` corresponds to SNOMED CT 256377006 (Red cells - CMV negative). Antigen matching can be recorded both with the SCD Transfusion Red Cell Antigen Match extension and with the antigen-negative and phenotype-matched processing codes; the two do not cover the same antigens (the processing codes cover C, E, K, Fy<sup>a</sup> and Jk<sup>b</sup>; the value set covers 15 antigens). `fresh-blood` duplicates the SCD Blood Product Age at Transfusion extension, and washed red cells (in the Blood Product Type value set) have no processing code. Which single representation should be used? *Affects: transfusion data; terminology.*

#### Profiles

- <a id="oq-19"></a>**OQ-19. Must Support scope.** Should each Must Support element that this guide adds beyond US Core ([KI-10](#ki-10)) be kept, with the reason stated on the profile, or removed? The terminology decision adds no constraints beyond US Core; applying the same principle here would remove the added Must Support elements. *Affects: implementation effort for systems that already support US Core.*
- <a id="oq-20"></a>**OQ-20. Transfusion links.** Should `Procedure.basedOn` (the link from a transfusion to its order) be Must Support, and should `Procedure.usedReference` remain Must Support? Should the SCD Transfusion Red Cell Antigen Match extension also be allowed on the transfusion order (ServiceRequest), and should antigen matching be recorded only with that extension or also with processing codes? *Affects: transfusion data.*
- <a id="oq-21"></a>**OQ-21. Reference targets.** The profiles narrow many references to USCDI-SCD profiles, which rejects some data that is valid under US Core: `Procedure.performer.actor` (Patient, RelatedPerson and Device are not allowed), `Procedure.reasonReference` (Observation, Procedure, DiagnosticReport and DocumentReference), `Procedure.usedReference` (Substance), `ServiceRequest.requester` (Organization, Patient, RelatedPerson and Device), `Encounter.participant.individual` (RelatedPerson), `Encounter.reasonReference` (Observations other than laboratory results, such as vital signs, and ImmunizationRecommendation), the Laboratory Result subject (Group, Device and Location), `CarePlan.author` (Patient, RelatedPerson, Device and CareTeam) and `CarePlan.addresses` (encounter diagnosis Conditions). `Encounter.diagnosis.condition` and `MedicationRequest.requester` are not narrowed. See [Reference Targets](conformance.html#reference-targets). Should the narrowing be kept, removed, or applied the same way in all profiles? Applying the terminology decision's principle of no constraints beyond US Core would remove the narrowing. *Affects: conformance of US Core data; server design.*
- <a id="oq-22"></a>**OQ-22. Pain score.** Pain severity scores are profiled as USCDI-SCD Vital Signs. US Core's vital signs binding does not include pain codes. Should pain scores use a different US Core profile (for example, Observation Screening Assessment)? *Affects: pain data in the Emergency Care use case; terminology; searching observations by category.*

#### Content

- <a id="oq-23"></a>**OQ-23. Connectathon.** The exchange process in [Figure 1](scope_and_usage.html#in-scope) was tested at a connectathon; its name and date are still to be added. *Affects: documentation only.*
- <a id="oq-25"></a>**OQ-25. Future extensions.** Should a future version add an extension for the patient's preferred SCD treatment center? *Affects: future versions.*
- <a id="oq-26"></a>**OQ-26. Client conformance levels per use case.** The guide defines one set of client levels for both use cases (see [Profile Conformance Summary](conformance.html#profile-conformance-summary)). Should it define separate levels for SCD Diagnosis and SCD Emergency Care clients? *Affects: client design; conformance testing.*
- <a id="oq-27"></a>**OQ-27. Content beyond the Version 1 lists.** Some parts of this guide do not correspond to a data element in ONC's Version 1 USCDI+ SCD lists: the SCD Vaso-Occlusive Crisis Frequency, SCD Newborn Screen Reference, SCD Iron Chelation Indication and SCD Blood Product Age at Transfusion extensions, and the USCDI-SCD ServiceRequest profile. Should they be kept in this version? See [USCDI+ SCD Data Elements](uscdi-plus.html#elements-in-this-guide-beyond-the-version-1-lists). *Affects: scope; implementation effort.*
- <a id="oq-28"></a>**OQ-28. Hydroxyurea adherence.** Should the SCD Hydroxyurea Adherence extension ([KI-7](#ki-7)) be retired in favor of the US Core [Medication Adherence](http://hl7.org/fhir/us/core/STU8.0.1/StructureDefinition-us-core-medication-adherence.html) extension, which applies to MedicationRequest? *Affects: medication data; extensions.*
- <a id="oq-29"></a>**OQ-29. Client display requirement.** Clients SHALL display SCD-relevant clinical data in human-readable form, but this guide defines no display criteria, so the requirement cannot be tested. Should it be a SHOULD? *Affects: client conformance; testing.*
- <a id="oq-30"></a>**OQ-30. Clinical realism of the examples.** A clinical review of the example scenario raised these points: the SpO2 of 91% conflicts with an "uncomplicated" vaso-occlusive crisis treated without transfusion; the medication doses cannot be checked without a body weight, and the hydroxyurea dose should follow the adult starting dose in the labeling; iron overload needing chelation is unlikely if all transfusions since 2004 were automated exchange; the outpatient hematologist is recorded as the ED attender; and the examples do not populate `Condition.evidence` (Must Support; see [OQ-11](#oq-11)) or the CarePlan `goal` and `careTeam` (Must Support). How should the examples be changed? *Affects: examples and test data.*
