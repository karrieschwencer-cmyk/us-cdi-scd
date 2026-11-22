<a id="top"></a>

This page maps the data elements in this guide to their FHIR profiles and elements. It lists every Must Support element and every required element for each profile, with its cardinality, data type and terminology binding. It is generated from the profile definitions, so it always matches them.

**Download:** [uscdi-scd-data-element-mapping.csv](uscdi-scd-data-element-mapping.csv) (opens in Excel)

**Source data elements:** ONC publishes the USCDI+ Sickle Cell Disease data element lists on the USCDI+ site: [SCD Diagnosis](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=84d4c4a23bdd03503cb59d0864e45a2a&view=sp) and [SCD Emergency Care](https://uscdiplus.healthit.gov/uscdiplus?id=uscdi_record&table=x_g_sshh_uscdi_sub_domain&sys_id=a7e444623bdd03503cb59d0864e45a96&view=sp). For where each of those data elements is represented in this guide, see [USCDI+ SCD Data Elements](uscdi-plus.html). The CSV download also has a "USCDI+ SCD Data Element" column that names, for each profile element, the USCDI+ SCD data elements it carries, taken from that page. The CSV also lists the elements of the US Core profiles that this guide uses directly for some USCDI+ SCD data elements (Source **US Core**). Its last four columns (Source System, Source Field, Available (Y/N/Partial) and Notes) are blank, for use as a gap analysis worksheet.

### How to read this chart

| Column | Meaning |
|---|---|
| Element | The FHIR element path. A name after a colon (for example, `extension:scd-voc-frequency`) is a named slice. |
| Card. | Cardinality: minimum..maximum occurrences. A minimum of 1 means the element is required. |
| MS | **Y** means the element is Must Support. See [Must Support](conformance.html#must-support). |
| Type | The data type. For references, the profiles the reference must conform to. |
| Binding | The value set the element's codes come from, and the binding strength. |
| Source | **USCDI-SCD** if this guide adds or changes the element; **Inherited** if it comes unchanged from the parent profile (usually US Core). |
| Additional USCDI (US Core) | **Y** means US Core marks the element as an additional USCDI requirement. See [Additional USCDI Requirement](glossary.html). |

Elements inherited from US Core are included so testers can see every requirement in one place. Child elements are listed only when their parent is listed.

---

### Extension Details

The parts of each SCD extension used in the profiles above.

<div style="overflow-x:auto" markdown="1">

| Extension | Part | Card. | Type | Binding | Description |
|---|---|---|---|---|---|

</div>

[Back to top](#top)
