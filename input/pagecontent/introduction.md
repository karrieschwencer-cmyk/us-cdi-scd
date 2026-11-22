{%- comment -%}
================================================================================
INTRODUCTION PAGE — introduction.md
================================================================================

{%- endcomment -%}

This page explains the purpose of this guide, how it relates to other standards, and how to read it.

In response to interoperability challenges raised by federal and non-federal partners, the Office of the National Coordinator for Health Information Technology (ONC) is using the United States Core Data for Interoperability Plus (USCDI+) service to develop a minimum core dataset for sickle cell disease (SCD) data exchange. USCDI+ extends the data elements in USCDI for specific use cases. Shared data elements help align the many separate efforts to collect and exchange SCD data. ONC publishes and maintains the dataset, which is informed by the needs of the people and organizations involved in SCD care. ONC's goal is more data exchange to improve care coordination, research comparability and national surveillance, and so improve health outcomes for people living with SCD. This guide represents the USCDI+ SCD data elements in FHIR.

### Relationship to Other Standards and Guides

This guide is based on [FHIR R4 (4.0.1)](http://hl7.org/fhir/R4/) and builds on [US Core 8.0.1](http://hl7.org/fhir/us/core/STU8.0.1/). For details on how it relates to US Core, USCDI, SMART App Launch and other specifications, see [Relationship to Other Implementation Guides](scope_and_usage.html#relationship-to-other-implementation-guides).

---

### How to Read This Guide

You don't need to read this guide front to back. The [Home](index.html) page lists where each type of reader should start ([Who This Guide Is For](index.html#who-this-guide-is-for)) and where to find the full list of pages and artifacts ([Guide Contents](index.html#guide-contents)).

#### Reading a profile page

Each profile page describes one type of record, such as a patient, a diagnosis or a lab result. The most useful parts are:

- **Description:** a plain-language summary of what the profile is for.
- **Key Elements table:** the elements that matter most. This is the best place to start.
- **Must Support (S):** elements marked with an **S** must be supported by conforming systems. See [Must Support](conformance.html#must-support).
- **Cardinality** (for example, `1..1` or `0..*`): how many times an element can appear. A `1` on the left means the element is required.
- **Bindings:** the code sets (value sets) an element's codes come from. An **Additional Binding** with the purpose **starter** is a reference list and does not constrain the element. See [Terminology Approach](terminology.html#terminology-approach).
- **Examples:** sample records showing the profile in use.

The **Differential** view shows only what this guide changes compared to the parent profile (a US Core profile, or the base FHIR resource for BiologicallyDerivedProduct). The **Snapshot** view shows the complete definition.

#### Conformance language

The words **SHALL**, **SHOULD** and **MAY** have specific meanings in this guide. See [Conformance Verbs](conformance.html#conformance-verbs).
