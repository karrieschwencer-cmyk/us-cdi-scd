{%- comment -%}
================================================================================
HOME PAGE — index.md
================================================================================
This is the landing page of the USCDI-SCD Implementation Guide.
It should provide a brief orienting summary and quick navigation links.

{%- endcomment -%}

> **Status: draft, version 0.1.0.** This guide has 15 known issues and 27 open questions; four of the open questions must be settled before systems in different organizations can exchange data. See [Known Issues and Open Questions](issues.html). To comment, see [How to Give Feedback](audience.html#how-to-give-feedback).

### Overview

The **USCDI+ Sickle Cell Disease Implementation Guide (USCDI-SCD)** specifies
FHIR R4 (4.0.1) profiles and supporting artifacts to enable standardized
exchange of clinical and administrative data relevant to people living with
sickle cell disease (SCD). This guide extends and aligns with
[US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/).

**Scope.** The guide covers the two use cases of ONC's USCDI+ SCD project:
SCD Diagnosis (recording and sharing an SCD diagnosis with its subtype) and
SCD Emergency Care (giving emergency care teams the patient's SCD history).
It defines profiles for the data elements on ONC's USCDI+ SCD lists for those
use cases, and server and client CapabilityStatements that import the US Core
CapabilityStatements. Other uses, such as public health reporting and research
exports, are out of scope. See [Scope and Usage](scope_and_usage.html).

**Coverage.** Of the 75 USCDI+ SCD data elements, 55 are represented in this
guide's profiles, 15 in US Core profiles used directly, 3 partly and 2 not yet.
See [USCDI+ SCD Data Elements](uscdi-plus.html).

Sponsorship by the HL7 Public Health Work Group is to be confirmed ([KI-15](issues.html#ki-15)).
<!-- TODO: Confirm the sponsorship together with the publication pathway (KI-15 on the Known Issues and Open Questions page). -->

---

### Who This Guide Is For

You don't need to read this guide front to back. Most hospitals implementing it involve two roles: a **developer**, who builds the interface, and a **business analyst**, who confirms that the hospital's data and workflows can meet the requirements. Each role has a reading path below. The [Audience](audience.html) page has more detail for each group, and the [Glossary](glossary.html) defines the terms used.

#### Developer

*You build or configure the FHIR interface: an EHR or health information exchange that returns SCD data (Server), or an application that requests and displays it (Client).*

| Step | Read | To learn |
|---|---|---|
| 1 | [Conformance Requirements](conformance.html) | Which actor you are implementing, what Must Support means, and how to handle missing data |
| 2 | [Server](CapabilityStatement-uscdi-scd-server.html) or [Client](CapabilityStatement-uscdi-scd-client.html) CapabilityStatement | The profiles, interactions and searches you must support, including the US Core requirements they import |
| 3 | [Exchange Workflow](workflow.html) | The steps of an exchange and the searches used at each step |
| 4 | [Profiles](profiles.html) and [Data Element Mapping](data-element-mapping.html) | Every required and Must Support element, with cardinality and bindings (also as a CSV checklist) |
| 5 | [Examples](examples.html) and [Test Data](testing.html) | Sample records, a test Bundle to load into your server, and the expected search results |
| 6 | [Downloads](downloads.html) | The FHIR package for validating your resources with the HL7 FHIR Validator |
| 7 | [Known Issues and Open Questions](issues.html) | Gaps to plan around, such as blood product retrieval and authorization between organizations |

#### Business Analyst

*You gather requirements, map the hospital's source data and workflows to this guide, and identify gaps before development starts.*

| Step | Read | To learn |
|---|---|---|
| 1 | [Scope and Usage](scope_and_usage.html) | The two use cases (SCD Diagnosis and SCD Emergency Care) and the profiles each one needs |
| 2 | [Overview](overview.html) | The information model and a summary of every profile |
| 3 | [Exchange Workflow](workflow.html) | Who exchanges data with whom, at which step, and what is still undecided |
| 4 | [USCDI+ SCD Data Elements](uscdi-plus.html) | Where each of ONC's USCDI+ SCD data elements is represented in this guide, and which are not yet covered |
| 5 | [Expected Source Systems](scope_and_usage.html#expected-source-systems-and-new-data-capture) | Which source systems typically hold each kind of data, and which data may need new documentation |
| 6 | [Data Element Mapping](data-element-mapping.html) | Every profile element to map to your source systems; download the CSV to use as a gap analysis worksheet |
| 7 | [Terminology](terminology.html) | The code systems used (SNOMED CT, LOINC, RxNorm, ICD-10-CM and CPT, following US Core). The SCD value sets are reference lists only; ONC maintains the SCD-relevant values in USCDI+ |
| 8 | [Security and Privacy](security.html) | Privacy rules that affect what can be shared, such as 42 CFR Part 2 and minors' records |
| 9 | [Known Issues and Open Questions](issues.html) | Items that may affect scope, timelines or decisions |

#### Other Readers

| If you are… | Start with | Then read |
|---|---|---|
| **A clinician or clinical informaticist** | [Background](background.html) and [Scope and Usage](scope_and_usage.html) | [Overview](overview.html) for the information model, then [Profiles](profiles.html) and [Examples](examples.html) |
| **A tester** | [Test Data](testing.html) | [Exchange Workflow](workflow.html), [Data Element Mapping](data-element-mapping.html) and the [Server CapabilityStatement](CapabilityStatement-uscdi-scd-server.html) |
| **A health system leader** (executive, CMIO or IT director) | [For Health System Leaders](audience.html#for-health-system-leaders) | [What This Guide Adds to US Core](conformance.html#what-this-guide-adds-to-us-core) and [Known Issues and Open Questions](issues.html) |
| **A terminologist** | [Terminology](terminology.html) | The value sets listed on the [Artifacts Summary](artifacts.html) page |
| **Policy or program staff** | [Background](background.html) and [Scope and Usage](scope_and_usage.html) | [Audience](audience.html) and [Security and Privacy](security.html) |
| **A patient or advocate** | [For Patients and Advocates](audience.html#for-patients-and-advocates) | [Security and Privacy](security.html) |

---

### Guide Contents

The menu bar at the top of each page lists every page in this guide. The [Artifacts Summary](artifacts.html) page lists every profile, extension, value set and example.

---

### Acknowledgements

This Implementation Guide was developed as part of the USCDI+ SCD initiative of the Office of the National Coordinator for Health Information Technology (ONC). The initiative is funded by the HHS Office of the Secretary Patient-Centered Outcomes Research Trust Fund (OS-PCORTF), administered by the Office of the Assistant Secretary for Planning and Evaluation (ASPE). The guide is the result of collaboration among people living with SCD (who often call themselves warriors) and their advocates, and the clinical, research, regulatory, public health and health IT communities.

This IG references a 2026 landscape analysis compiled by the USCDI+ SCD project team and informed by a Technical Expert Panel. ONC published Version 1 of the USCDI+ SCD data element lists for the [Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp) use cases in October 2026.

---

### Dependencies

This implementation guide relies on the following published FHIR packages:

{% include dependency-table.xhtml %}

---

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

---

### Global Profiles

{% include globals-table.xhtml %}

---

### Intellectual Property Statements

{% include ip-statements.xhtml %}
