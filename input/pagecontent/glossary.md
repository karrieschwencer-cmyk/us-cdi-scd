{%- comment -%}
================================================================================
GLOSSARY PAGE — glossary.md
================================================================================
{%- endcomment -%}

This page defines the technical, standards and clinical terms used in this guide. Terms are listed alphabetically within each section.

### FHIR and Standards Terms

| Term | Definition |
|---|---|
| **Actor** | A system that plays a defined role in an exchange. This guide defines a CapabilityStatement for two actors, the USCDI-SCD Client and the USCDI-SCD Server. A third actor, the data intermediary, has a role still to be decided ([OQ-1](issues.html#oq-1)). See [Conformance Requirements](conformance.html#capabilitystatements). |
| **Additional Binding** | A FHIR tools extension (`additional-binding`) that links a coded element to a value set in addition to its main binding. Its purpose says how the value set is used. With the purpose **starter** ("a good set of codes to start with"), the value set is a reference list: it does not constrain the element, and the main (US Core) binding still applies. See [Terminology Approach](terminology.html#terminology-approach). |
| **Additional USCDI Requirement** | In US Core, an element that is not flagged Must Support but is needed to meet USCDI. US Core describes which systems are required to support these elements. See [US Core Must Support](http://hl7.org/fhir/us/core/STU8.0.1/must-support.html). |
| **Binding (binding strength)** | The link between a coded element and a value set. FHIR defines four [binding strengths](http://hl7.org/fhir/R4/terminologies.html#strength): **required** (codes SHALL come from the value set), **extensible** (codes SHALL come from the value set if a suitable code exists), **preferred** (codes from the value set are encouraged) and **example** (the value set only illustrates the kinds of codes expected). |
| **Break-glass access** | Emergency access to records that a user could not normally see, given when they are needed for urgent care. Break-glass access is usually logged and reviewed afterward. |
| **Bundle** | A FHIR resource that groups other resources. This guide uses a *transaction* Bundle to load test data and *searchset* Bundles to show expected search results. |
| **Canonical URL** | The permanent, unique identifier of a conformance resource such as a profile, extension or value set. All artifacts in this guide have canonical URLs beginning with `http://hl7.org/fhir/us/uscdi-scd/`. |
| **CapabilityStatement** | A FHIR resource that states which resources, interactions and searches a system supports, or must support to conform to a guide. |
| **Cardinality** | How many times an element can appear, written as minimum..maximum. For example, `1..1` means exactly once (required) and `0..*` means optional and repeating. |
| **Code system** | A set of codes with defined meanings, such as SNOMED CT or LOINC. |
| **Connectathon** | An HL7 testing event where implementers test exchanges between their systems using a FHIR specification. |
| **Data Absent Reason** | A FHIR [extension](http://hl7.org/fhir/R4/extension-data-absent-reason.html) and code system used to say why a required value is missing. See [Missing Data](conformance.html#missing-data). |
| **Data intermediary** | A system, such as a health information exchange or network, that passes queries and records between the system requesting data and the systems that hold it. See Figure 1 on the [Scope and Usage](scope_and_usage.html#in-scope) page. |
| **Differential / Snapshot** | Two views of a profile. The differential shows only what the profile changes compared to its parent; the snapshot shows the complete definition. |
| **Extension** | An element added to a FHIR resource to carry information that the base resource does not define. See [Extensions](extensions.html). |
| **FHIR** | Fast Healthcare Interoperability Resources, the HL7 standard for exchanging health information. This guide uses FHIR R4 (4.0.1). |
| **FHIR Shorthand (FSH) / SUSHI** | FSH is a language for writing FHIR profiles and other artifacts. SUSHI compiles FSH into FHIR resources. This guide's source is written in FSH. |
| **ICD-10-CM** | International Classification of Diseases, Tenth Revision, Clinical Modification: the US classification of diagnoses, used for billing and reporting. |
| **Implementation Guide (IG)** | A set of rules and documentation describing how FHIR is used for a particular purpose. |
| **Imported CapabilityStatement** | A CapabilityStatement whose requirements are included in another one through `CapabilityStatement.imports`. The USCDI-SCD CapabilityStatements import the US Core 8.0.1 Server and Client CapabilityStatements. |
| **ISBT 128** | The international standard for the identification, labeling and coding of medical products of human origin, including blood products. |
| **LOINC** | Logical Observation Identifiers Names and Codes: the standard code system for laboratory tests and clinical observations. |
| **Must Support** | A flag on a profile element meaning conforming systems must be able to populate and process it. See [Must Support](conformance.html#must-support). |
| **NPM package** | The package format, based on the Node Package Manager (NPM) format, used to distribute a FHIR implementation guide as a single `package.tgz` file for validators and other tools. See [Downloads](downloads.html). |
| **OAuth 2.0** | An authorization framework that lets an application get limited access to a service on behalf of a user or another system. SMART App Launch is based on OAuth 2.0. |
| **OID** | Object identifier: a numeric identifier used by some terminology systems, such as VSAC and CDA documents, to identify code systems and value sets. |
| **Profile** | A set of constraints on a FHIR resource for a particular use, such as the USCDI-SCD Patient profile. See [Profiles](profiles.html). |
| **Resource** | The basic unit of exchange in FHIR, such as Patient, Condition or Observation. |
| **RxNorm** | The National Library of Medicine's standard code system for clinical drugs. |
| **Search parameter** | A named criterion a client can use to search for resources on a FHIR server, such as `patient` or `category`. |
| **SMART App Launch** | An HL7 specification for authorizing applications to access FHIR data using OAuth 2.0. See [SMART App Launch](http://hl7.org/fhir/smart-app-launch/). |
| **SNOMED CT** | A comprehensive clinical terminology used to code diagnoses, procedures, findings and substances. This guide uses the US Edition. |
| **THO (HL7 Terminology)** | HL7's terminology publication ([terminology.hl7.org](http://terminology.hl7.org)), which publishes the code systems and value sets that HL7 maintains, such as the observation category codes. |
| **UCUM** | The Unified Code for Units of Measure, used for units such as `mg/dL` or `d` (days). |
| **US Core** | The HL7 FHIR guide that sets the baseline requirements for exchanging USCDI data in the United States. This guide builds on [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/). |
| **USCDI / USCDI+** | The United States Core Data for Interoperability (USCDI) is the ONC-defined set of data elements for nationwide exchange. USCDI+ extends USCDI with data elements for specific domains and programs, such as sickle cell disease. |
| **USCDI-SCD** | The prefix used in the names of this guide's artifacts, such as the USCDI-SCD Patient profile and the USCDI-SCD Server CapabilityStatement. The guide's title is "USCDI+ Sickle Cell Disease Implementation Guide"; USCDI-SCD is the short form used in artifact names. |
| **Value set** | A set of codes, drawn from one or more code systems, for use in a particular element. See [Terminology](terminology.html). |
| **VSAC** | The National Library of Medicine's [Value Set Authority Center](https://vsac.nlm.nih.gov/), which publishes and maintains value sets. |

### Clinical Terms

| Term | Definition |
|---|---|
| **Acute chest syndrome (ACS)** | A lung complication of SCD in which a new infiltrate appears on chest imaging, together with symptoms such as fever, chest pain, cough, rapid breathing or low blood oxygen. |
| **Alloimmunization** | The formation of antibodies against red cell antigens of donor blood, which can make future transfusions harder to match. |
| **Antigen matching** | Selecting donor red cells that match the patient for red cell antigens beyond ABO and RhD. For people with SCD, matching for the Rh antigens C and E (or C/c and E/e) and for K is recommended ([ASH 2020 transfusion guideline](references.html#ash-2020-transfusion)). *Extended* matching adds further antigens, such as Jk<sup>a</sup>/Jk<sup>b</sup>, Fy<sup>a</sup>/Fy<sup>b</sup> and S/s. |
| **Aplastic crisis** | A temporary stop in red blood cell production, most often caused by parvovirus B19 infection, leading to severe anemia with a very low reticulocyte count. |
| **CBC (complete blood count)** | A laboratory test that measures red blood cells, white blood cells, platelets and hemoglobin. |
| **CMV-negative** | Describes a blood product from a donor who tested negative for cytomegalovirus (CMV), a common virus that can be passed on through transfusion. |
| **eGFR (CKD-EPI)** | Estimated glomerular filtration rate: a measure of kidney function calculated from blood creatinine. CKD-EPI (Chronic Kidney Disease Epidemiology Collaboration) is the name of the equation used to calculate it. |
| **Exchange transfusion** | A transfusion in which the patient's red cells are removed and replaced with donor red cells. It can be done manually or with an automated machine (automated red cell exchange). |
| **HbF (fetal hemoglobin)** | The main type of hemoglobin before birth. Higher HbF levels reduce sickling. |
| **Hematopoietic stem cell transplantation (HSCT)** | A transplant of blood-forming stem cells (hematopoietic progenitor cells) from bone marrow, peripheral blood or cord blood. |
| **Hemoglobin fractionation** | Laboratory testing, such as hemoglobin electrophoresis or high-performance liquid chromatography, that measures the proportions of hemoglobin types (for example, HbA, HbS, HbF, HbA2 and HbC). |
| **Hydroxyurea** | An oral disease-modifying medication for SCD that increases fetal hemoglobin (HbF). |
| **Iron chelation** | Medication therapy (such as deferasirox, deferoxamine or deferiprone) that removes excess iron from the body. |
| **Iron overload (transfusional hemosiderosis)** | The build-up of iron in organs such as the liver and heart as a result of repeated transfusions. |
| **LDH (lactate dehydrogenase)** | An enzyme released when cells, including red blood cells, break down. A raised LDH level is a marker of hemolysis. |
| **Leukoreduction** | Removal of white blood cells from a blood product. |
| **Newborn screening** | State public health programs that test newborns for certain conditions, including SCD. |
| **NRS (numeric rating scale)** | A pain scale on which the patient rates pain from 0 (no pain) to 10 (worst pain). |
| **NSAID** | Nonsteroidal anti-inflammatory drug, such as ibuprofen. |
| **Packed red blood cells (pRBCs)** | A blood product made of red blood cells with most of the plasma removed. |
| **SCD subtypes (HbSS, HbSC, HbS-β⁰-thalassemia, HbS-β⁺-thalassemia)** | The main forms of SCD. HbSS (sickle cell anemia): two copies of the sickle hemoglobin gene. HbSC: one sickle and one hemoglobin C gene. HbS-β-thalassemia: one sickle gene and one beta-thalassemia gene, with no beta-globin produced from that gene (β⁰) or reduced production (β⁺). Less common types, such as HbSD, HbSE and HbS-O<sup>Arab</sup>, are also listed in the SCD Diagnosis Value Set. In this guide the subtype is recorded in the diagnosis code. |
| **Sickle cell disease (SCD)** | A group of inherited red blood cell disorders in which an abnormal hemoglobin (hemoglobin S) causes red blood cells to become rigid and sickle-shaped. |
| **Sickle cell trait** | Carrying one sickle hemoglobin gene and one typical gene. Sickle cell trait is not a form of SCD. |
| **Splenic sequestration** | Sudden trapping of red blood cells in the spleen, causing the spleen to enlarge and hemoglobin to fall rapidly. |
| **SpO2** | Oxygen saturation measured by pulse oximetry: the percentage of hemoglobin in the blood that is carrying oxygen. |
| **Transcranial Doppler (TCD)** | An ultrasound test of blood flow speed in the brain's arteries, used to screen children with HbSS or HbS-β⁰-thalassemia for stroke risk; the [NHLBI 2014 expert panel report](references.html#nhlbi-2014) recommends annual screening from age 2 to at least age 16. |
| **Vaso-occlusive crisis (VOC)** | An episode of acute pain caused by sickled red blood cells blocking blood flow. |
| **Warrior** | A term used by the SCD community for a person living with SCD. |

### Acronyms

| Acronym | Meaning |
|---|---|
| **ASH** | American Society of Hematology |
| **ASPE** | Office of the Assistant Secretary for Planning and Evaluation |
| **CDA** | Clinical Document Architecture (HL7) |
| **CMIO** | Chief medical information officer |
| **ED** | Emergency department |
| **EHR** | Electronic health record |
| **HCO** | Health care organization (used in Figure 1, on the Scope and Usage page) |
| **HHS** | U.S. Department of Health and Human Services |
| **HIE** | Health information exchange |
| **HL7** | Health Level Seven International |
| **NHLBI** | National Heart, Lung, and Blood Institute |
| **NIST** | National Institute of Standards and Technology |
| **NLM** | National Library of Medicine |
| **ONC** | Office of the National Coordinator for Health Information Technology |
| **OS-PCORTF** | HHS Office of the Secretary Patient-Centered Outcomes Research Trust Fund |
| **RBAC** | Role-based access control |
| **SCD** | Sickle cell disease |
| **TEP** | Technical Expert Panel |
| **TLS** | Transport Layer Security |
