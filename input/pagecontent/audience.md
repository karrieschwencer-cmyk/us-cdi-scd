{%- comment -%}
================================================================================
AUDIENCE PAGE — audience.md
================================================================================
{%- endcomment -%}

This Implementation Guide is intended for multiple audiences. The table below
identifies the main reader groups and points each to the most relevant pages.
The sections below the table give more detail for six key groups. The [Home](index.html#who-this-guide-is-for) page gives a step-by-step reading path for developers and business analysts.

| Audience | Relevant pages | Prerequisites |
|---|---|---|
| **Health System Leaders** (executives, CMIOs, IT directors) | [For Health System Leaders](#for-health-system-leaders), [Scope and Usage](scope_and_usage.html), [Conformance Requirements](conformance.html#what-this-guide-adds-to-us-core), [Known Issues and Open Questions](issues.html) | None |
| **Clinical Informaticists** | [Background](background.html), [Scope and Usage](scope_and_usage.html), [Overview](overview.html), [Profiles](profiles.html) | SCD clinical knowledge; familiarity with FHIR R4 concepts helpful |
| **EHR / Health IT Developers** | [Conformance Requirements](conformance.html), [Profiles](profiles.html), [Extensions](extensions.html), [Terminology](terminology.html), [Downloads](downloads.html) | FHIR R4 implementation experience; FSH/SUSHI knowledge helpful |
| **Business Analysts** | [Scope and Usage](scope_and_usage.html), [Exchange Workflow](workflow.html), [USCDI+ SCD Data Elements](uscdi-plus.html), [Data Element Mapping](data-element-mapping.html), [Terminology](terminology.html), [Known Issues and Open Questions](issues.html) | Knowledge of the organization's clinical data sources and workflows; FHIR knowledge helpful but not required |
| **Testers** | [Test Data](testing.html), [Exchange Workflow](workflow.html), [Conformance Requirements](conformance.html) | FHIR R4 familiarity |
| **Healthcare Organizations / Implementers** | [Conformance Requirements](conformance.html), [Security and Privacy](security.html), [Scope and Usage](scope_and_usage.html) | Understanding of US Core and SMART App Launch |
| **Hematologists / Clinical SMEs** | [Background](background.html), [Scope and Usage](scope_and_usage.html), [Overview](overview.html) | Basic health IT literacy; FHIR knowledge not required |
| **Payers / Care Management Programs** | [Scope and Usage](scope_and_usage.html), [Profiles](profiles.html), [USCDI-SCD CarePlan](StructureDefinition-uscdi-scd-careplan.html), [USCDI-SCD ServiceRequest](StructureDefinition-uscdi-scd-servicerequest.html) | FHIR R4 data model familiarity |
| **Public Health / Registry Programs** | [Background](background.html), [Scope and Usage](scope_and_usage.html), [USCDI-SCD Laboratory Result](StructureDefinition-uscdi-scd-laboratory-result.html), [USCDI-SCD Condition Problems and Health Concerns](StructureDefinition-uscdi-scd-condition-problems.html) | FHIR R4 familiarity; epidemiology background |
| **Policy Makers / Program Officers** | [Introduction](introduction.html), [Background](background.html), [Scope and Usage](scope_and_usage.html), [Audience](audience.html) | General health IT policy awareness |
| **Patients and Advocates** | [For Patients and Advocates](#for-patients-and-advocates), [Introduction](introduction.html), [Security and Privacy](security.html) | None |

---

### For Health System Leaders

This section summarizes what implementing this guide involves for a hospital or health system.

- **The problem.** Care for people living with SCD is often fragmented across settings, and important information may not be available when a patient sees a new provider or arrives at an emergency department. See [Background](background.html).
- **What the guide supports.** Two use cases defined by ONC's USCDI+ SCD project: recording and sharing an SCD diagnosis with its subtype (SCD Diagnosis), and giving emergency care teams the patient's SCD history (SCD Emergency Care). See [Scope and Usage](scope_and_usage.html#use-case-scenarios) for a scenario of each.
- **Starting point.** The guide builds on US Core 8.0.1. Both of its CapabilityStatements import the US Core CapabilityStatements. Of the 75 USCDI+ SCD data elements, 55 are represented in this guide's profiles, 15 in US Core profiles used directly, 3 partly and 2 not yet. The additions on top of US Core are listed under [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core).
- **Status.** This is a draft (version 0.1.0), developed under the FHIR Community Process. It has been tested at a connectathon and is reviewed by subject matter experts and the HL7 Public Health Work Group. Parts of the exchange workflow, including how records are located and how systems in different organizations authorize each other, are still open questions. See [Known Issues and Open Questions](issues.html).
- **Requirements.** Conformance to this guide is voluntary unless a program or agreement that an organization participates in requires it.

---

### For Clinical Informaticists

Clinical informaticists bridge clinical practice and health IT, so this guide's design choices matter most to them. The most useful parts are:

- **The use cases** in [Scope and Usage](scope_and_usage.html): SCD Diagnosis and SCD Emergency Care, the two USCDI+ SCD use cases, with a scenario for each.
- **The information model** in [Overview](overview.html): how the clinical concepts (diagnosis and subtype, labs, transfusions, medications) relate to each other and to FHIR resources.
- **The profiles** in [Profiles](profiles.html): which data elements are required or Must Support, and how SCD-specific information such as the SCD subtype and transfusion antigen matching is captured.
- **The value sets** in [Terminology](terminology.html): the SNOMED CT, LOINC, RxNorm and ICD-10-CM codes listed for SCD diagnoses, complications, lab tests and treatments. They are reference lists and add no constraints beyond US Core; the SCD-relevant values are maintained by ONC in USCDI+.

Feedback on whether the profiles and value sets reflect real clinical workflows is especially valuable. See [How to Give Feedback](#how-to-give-feedback).

---

### For Developers and Implementers

Developers building systems that send or receive SCD data should start with [Conformance Requirements](conformance.html), which explains what servers and clients must support and what this guide adds to US Core, then review the [Exchange Workflow](workflow.html), the [Profiles](profiles.html) and the [Examples](examples.html).

**Getting the artifacts**

- The FHIR package (NPM), definitions and examples are on the [Downloads](downloads.html) page.
- The FHIR Shorthand (FSH) source for this guide is maintained on GitHub at [github.com/FHIR/us-cdi-scd](https://github.com/FHIR/us-cdi-scd).

**Validating an implementation**

- Use the [HL7 FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core/releases) (download `validator_cli.jar`; an online version is at [validator.fhir.org](https://validator.fhir.org)) with this guide's package to check that your resources conform to the USCDI-SCD profiles. The [Test Data](testing.html#how-to-test-conformance) page gives an example command and a checklist for each requirement.
- Because USCDI-SCD builds on US Core, your system should also pass US Core validation and testing.

**Tools**

- [SUSHI](https://fshschool.org) compiles the FSH source into FHIR resources.
- The [HL7 IG Publisher](https://github.com/HL7/fhir-ig-publisher) builds this guide from source.

---

### For Business Analysts

Business analysts help an organization decide what it takes to implement this guide: which source systems hold the data, how the data is coded today, and which workflows change. No FHIR programming knowledge is needed.

- **Confirm the scope.** [Scope and Usage](scope_and_usage.html) describes the two use cases, a scenario for each, and the profiles each one needs. Start with the use case your organization is implementing.
- **Start from the USCDI+ data elements.** The [USCDI+ SCD Data Elements](uscdi-plus.html) page shows where each of ONC's USCDI+ SCD data elements is represented, and which are not yet covered.
- **Map the data.** The [Data Element Mapping](data-element-mapping.html) page lists every required and Must Support element. Its CSV download can be used as a gap analysis worksheet: for each element, record the source system, the field, and whether the data is available. Blood product and transfusion data may be held outside the EHR, for example in a blood bank system. [Expected Source Systems and New Data Capture](scope_and_usage.html#expected-source-systems-and-new-data-capture) lists the systems that typically hold each kind of data.
- **Check the codes.** [Terminology](terminology.html) lists the code systems used. Following the US Core bindings, diagnoses use SNOMED CT or ICD-10-CM, laboratory results and vital signs use LOINC, and medications use RxNorm. Locally coded data needs to be mapped to these code systems. This guide adds no terminology constraints beyond US Core. The SCD-relevant values for data elements such as Problems, Medications and Tests are maintained by ONC in the USCDI+ SCD data element lists (see [Terminology Approach](terminology.html#terminology-approach)). Feedback on those values goes to ONC.
- **Size the work.** [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core) lists the additions for systems that already support US Core.
- **Understand the workflow.** [Exchange Workflow](workflow.html) describes who requests data from whom, and at which step.
- **Review privacy requirements.** [Security and Privacy](security.html) covers rules, such as 42 CFR Part 2 and minors' records, that can affect what data may be shared.
- **Plan for open items.** [Known Issues and Open Questions](issues.html) lists limitations and undecided questions, and what each one affects.

The [Glossary](glossary.html) defines the FHIR and clinical terms used in this guide.

---

### For Hematologists and Clinical Subject Matter Experts

You don't need technical knowledge to help make this guide clinically accurate. In plain terms, this guide defines a set of standard electronic "forms" (called **profiles**) for SCD information, such as a patient's diagnosis and SCD type, a vaso-occlusive crisis visit, lab results like hemoglobin S percentage, and blood transfusions. It also lists the standard **codes** used to fill in those forms, so that every computer system means the same thing by "HbSS disease" or "acute chest syndrome".

How you can help:

- **Review the clinical content.** The [Profiles](profiles.html) page describes each form in plain language, and the [Examples](examples.html) page shows a complete fictional patient story. Check whether the information captured is what you would need when caring for a patient with SCD.
- **Check the codes.** The [Terminology](terminology.html) page lists the diagnoses, complications, lab tests and medications included. The SCD-relevant values for USCDI+ data elements such as Problems, Medications, Procedures and Tests are maintained by ONC in USCDI+, so feedback on those values goes to ONC (see [How to Give Feedback](#how-to-give-feedback)).
- **Share your feedback.** See [How to Give Feedback](#how-to-give-feedback).

Clinical input shapes future versions of this guide, including which data elements are required and how they are coded.

---

### For Patients and Advocates

This guide is a technical rulebook that helps different health care computer systems share medical information about people living with sickle cell disease, accurately and securely.

Today, when a person with SCD sees a new doctor or goes to an emergency department, important information such as their type of SCD, past pain crises, transfusion history and medications may not be available. This guide is designed to help make that information available to the care team when it's needed. Once health care organizations put it in place, it aims to support:

- **Better-informed care in the emergency department,** because the care team can see the patient's SCD history.
- **Smoother transitions** when changing doctors or care settings.
- **Shared test results,** because earlier results can be sent with the patient's record.
- **Transfusion information,** such as the blood products a patient received and the antigen matching used, as far as the systems involved record it.

Some parts of how the exchange will work, such as how a patient's records are found, are still being decided (see [Known Issues and Open Questions](issues.html)).

Protecting your information is a core part of this guide. It relies on the security and privacy requirements described in [Security and Privacy](security.html), including HIPAA. This guide does not change your privacy rights or your consent choices.

Patients and advocates are welcome to share feedback; see [How to Give Feedback](#how-to-give-feedback).

---

### Frequently Asked Questions

**Our EHR already supports US Core. Do we need this guide?**
Much of what this guide needs is already in US Core. To support the SCD use cases, a system also needs the additions listed under [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core).

**Is this guide final?**
No. It is a draft (version 0.1.0). Its known limitations and open questions are listed on [Known Issues and Open Questions](issues.html).

**Which version of US Core does it use?**
US Core 8.0.1, which implements USCDI v5. Newer versions of US Core have since been published ([KI-14](issues.html#ki-14)).

**Does it cover all of ONC's USCDI+ SCD data elements?**
Of the 75 USCDI+ SCD data elements, 55 are represented in this guide's profiles, 15 in US Core profiles used directly, 3 partly and 2 not yet. See [USCDI+ SCD Data Elements](uscdi-plus.html).

---

### How to Give Feedback

Comments from all readers are welcome:

- **Comments on this guide, including the SCD-relevant values in USCDI+:** send them to ONC. <!-- TODO: Add the ONC feedback address once ONC provides it. Do not publish without it. -->
- **Change requests:** the **Propose a change** link at the bottom of each page opens an HL7 Jira ticket. The Jira specification for this guide is not yet registered, so these tickets may not yet be associated with this guide ([KI-13](issues.html#ki-13)).
- **Implementation questions:** the [chat.fhir.org](https://chat.fhir.org) community forum.
- **Problems with the source files:** the [GitHub repository](https://github.com/FHIR/us-cdi-scd/issues).

