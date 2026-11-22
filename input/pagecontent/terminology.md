This page describes the code systems, value sets and local codes used in this guide. Using standard codes lets every system interpret SCD information the same way. For example, "HbSS disease" or "hemoglobin S percentage" means the same thing in every system.

All terminology requirements of [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/terminology.html) apply.

---

### Terminology Approach

This guide adds no terminology constraints beyond US Core.

- **US Core bindings apply.** Where a profile element has a US Core binding (for example, LOINC for laboratory tests or RxNorm for medications), that binding applies unchanged.
- **The value sets are reference lists.** The value sets on this page list codes commonly used in SCD care. They do not constrain exchange: a code that is valid under US Core is valid under this guide. They can help with tasks such as prioritizing what to display.
- **Reference bindings.** Five value sets are linked to the profile elements they describe. Each link is shown as an **Additional Binding** on the profile page, with the purpose **open**. An open additional binding does not constrain the element, the US Core binding still applies, and the FHIR Validator does not check it. The elements are `Condition.code` in both Condition profiles (SCD Diagnosis and SCD Acute Complication), `Procedure.code` (SCD Procedure), `Medication.code` and `MedicationRequest.medication[x]` (SCD Medication), and `Observation.code` in the Laboratory Result profile (SCD Laboratory Panel).
- **Example bindings.** Three value sets are bound with **example** strength to elements that have no US Core binding (on the BiologicallyDerivedProduct profile and the antigen match extension). They show the kinds of codes expected without requiring them.
- **USCDI+ maintains the SCD-relevant values.** ONC's USCDI+ SCD data element lists include, in the "Additional Information" field of some data elements, the SCD-relevant values for that data element. This applies to ten data elements: Care Plan, Diagnostic Imaging Test, Disability Status, Functional Status, Medications, Mental/Cognitive Status, Problems, Procedures, SDOH Problems/Health Concerns and Tests. Problems, Medications and Tests are on both the [SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) lists; the others are on the Emergency Care list only. USCDI+ is where these values are maintained. See [USCDI+ SCD Data Elements](uscdi-plus.html).

---

### Value Sets

This guide defines nine value sets. Each name links to the full list of codes. The Binding column shows how each value set is linked to a profile (see [Terminology Approach](#terminology-approach)).

| Value Set | Code systems | Used with | Binding |
|---|---|---|---|
| [SCD Diagnosis](ValueSet-scd-diagnosis-vs.html) | ICD-10-CM, SNOMED CT | `Condition.code` in both Condition profiles ([Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) and [Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html)): SCD diagnoses, covering all major SCD subtypes | Additional Binding, purpose open (US Core preferred binding applies) |
| [SCD Acute Complication](ValueSet-scd-acute-complication-vs.html) | SNOMED CT, ICD-10-CM | `Condition.code` in both Condition profiles ([Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) and [Encounter Diagnosis](StructureDefinition-uscdi-scd-condition-encounter-diagnosis.html)): acute complications such as VOC, acute chest syndrome, splenic sequestration, aplastic crisis, priapism, acute kidney injury and delayed hemolytic transfusion reaction | Additional Binding, purpose open (US Core preferred binding applies) |
| [SCD Laboratory Panel](ValueSet-scd-laboratory-panel-vs.html) | LOINC | `Observation.code` in [Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html): CBC, hemoglobin fractionation, hemolysis markers, iron studies including liver iron concentration, kidney and liver function, immunohematology (including the direct antiglobulin test and antigen typing), blood culture and C-reactive protein | Additional Binding, purpose open (US Core extensible binding applies) |
| [SCD Vital Signs](ValueSet-scd-vital-signs-vs.html) | LOINC | `Observation.code` in [Vital Signs](StructureDefinition-uscdi-scd-vital-signs.html): US Core vital signs plus the pain severity score used to assess VOC | Reference list only; not linked to the profile (US Core extensible binding applies) |
| [SCD Medication](ValueSet-scd-medication-vs.html) | RxNorm | `Medication.code` in [Medication](StructureDefinition-uscdi-scd-medication.html) and `medication[x]` in [MedicationRequest](StructureDefinition-uscdi-scd-medicationrequest.html): disease-modifying therapies, gene therapies, iron chelation agents and preventive antibiotics (RxNorm ingredient codes, for grouping; exchanged codes follow US Core) | Additional Binding, purpose open (US Core extensible binding applies) |
| [SCD Procedure](ValueSet-scd-procedure-vs.html) | SNOMED CT | `Procedure.code` in [Procedure](StructureDefinition-uscdi-scd-procedure.html): transfusion, exchange transfusion, stem cell collection and transplantation, gene therapy, cholecystectomy, hip replacement and monitoring procedures such as transcranial Doppler and liver MRI | Additional Binding, purpose open (US Core preferred binding applies) |
| [SCD Blood Product Type](ValueSet-scd-blood-product-type-vs.html) | SNOMED CT | `productCode` in [BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html): red blood cell and hematopoietic progenitor cell products | Example |
| [SCD Blood Product Processing](ValueSet-scd-blood-product-processing-vs.html) | SCD Blood Product Processing (local) | `processing.procedure` in [BiologicallyDerivedProduct](StructureDefinition-uscdi-scd-biologicallyderivedproduct.html): processing steps such as leukoreduction, irradiation and antigen matching | Example |
| [SCD Red Cell Antigen](ValueSet-scd-red-cell-antigen-vs.html) | SNOMED CT | The [SCD Transfusion Red Cell Antigen Match](StructureDefinition-scd-transfusion-antigen-match.html) extension: Rh (including D), Kell, Duffy, Kidd and MNS antigens used for matching | Example |

These value sets are drafts. Some codes are still under terminology review. The value sets are intended for future submission to the [Value Set Authority Center (VSAC)](https://vsac.nlm.nih.gov/).

---

### Local Code Systems

This guide defines two local code systems for SCD concepts that standard terminologies do not cover.

#### [SCD Observation Category](CodeSystem-scd-observation-category-cs.html)
Categories that group SCD observations, used in the examples. They supplement, and do not replace, the standard HL7 observation categories (such as `laboratory` and `vital-signs`), so an observation can carry both. Whether to keep them, or use standard codes instead, is an open question ([OQ-14](issues.html#oq-14)).

| Code | Meaning |
|---|---|
| `hemoglobin-fractionation` | Hemoglobin fractionation or electrophoresis results (HbS %, HbF %, HbA %, HbA2 %, HbC %) |
| `iron-overload-assessment` | Iron overload assessment for patients on chronic transfusion (serum ferritin, liver iron concentration, transferrin saturation) |
| `transfusion-medicine` | Immunohematology and transfusion results (ABO/Rh typing, extended antigen phenotyping, antibody identification, crossmatch) |
| `scd-pain-assessment` | Pain severity assessments, such as numeric rating scale scores during a VOC |
| `scd-disease-monitoring` | Other SCD monitoring, such as functional asplenia markers, organ function screening and complication surveillance |

#### [SCD Blood Product Processing](CodeSystem-scd-blood-product-processing-cs.html)
Processing steps and attributes of blood products used for SCD transfusion, such as leukoreduction, irradiation, CMV-negative and HbS-negative (sickle cell trait negative) units, specific antigen-negative units, extended phenotype matching and fresh blood. These codes are used in `BiologicallyDerivedProduct.processing.procedure` (through the [SCD Blood Product Processing](ValueSet-scd-blood-product-processing-vs.html) value set). The [NHLBI 2014 expert panel report](references.html#nhlbi-2014) notes that most red cell units given to people with SCD in the United States are leukoreduced, and that many institutions provide sickle-negative units so that HbS% can be tracked when HbS targets are used.

---

### External Code Systems

| Code System | URI | Used for |
|---|---|---|
| SNOMED CT (US Edition) | `http://snomed.info/sct` | Diagnoses, procedures, blood products, antigens, findings |
| LOINC | `http://loinc.org` | Laboratory tests, vital signs, assessments |
| RxNorm | `http://www.nlm.nih.gov/research/umls/rxnorm` | Medications |
| ICD-10-CM | `http://hl7.org/fhir/sid/icd-10-cm` | Diagnoses (alongside SNOMED CT, for billing and reporting) |
| CPT | `http://www.ama-assn.org/go/cpt` | Procedures (alongside SNOMED CT; used in the transfusion example; no value set includes CPT codes yet) |
| UCUM | `http://unitsofmeasure.org` | Units of measure |
| HL7 Terminology | `http://terminology.hl7.org` | Encounter class, condition and observation categories, status codes |

[ISBT 128](https://www.isbt128.org/), the international standard for blood product coding, is planned for future versions of this guide, for blood product types and red cell antigens.

#### Coding guidance

- **Diagnoses:** the examples in this guide include both a SNOMED CT code and an ICD-10-CM code for SCD diagnoses (see the [SCD diagnosis example](Condition-maya-johnson-scd-diagnosis.html)). The US Core Condition binding includes both code systems.
- **Medications:** US Core requires RxNorm codes (extensible binding), and the USCDI-SCD Medication and MedicationRequest profiles inherit this. NDC codes may be added as an additional coding.
- **Laboratory results:** use LOINC codes, as US Core requires for laboratory observations.

---

### Terminology Licensing

SNOMED CT, LOINC, CPT and other code systems are subject to their own license terms. See the Intellectual Property Statements on the [Home](index.html) page.
