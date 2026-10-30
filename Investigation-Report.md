#### **Failed Login Investigation Report**



##### **1. Investigation Overview**



\*\*Project:\*\* Windows SOC – Failed Login Detection  

\*\*Event ID:\*\* 4625  

\*\*Event Date:\*\* October 29, 2026  

\*\*Event Time:\*\* 8:21:42 AM  

\*\*Severity:\*\* Undetermined – requires further investigation



##### **2. Event Details**



| Field | Observed Value |

|---|---|

| Event ID | 4625 |

| Username | - |

| Logon Type | 2 – Interactive |

| IP Address | - |

| Status | 0xc000006d |

| Process | Copilot application |



##### **3. Technical Analysis**



Event ID 4625 indicates that a logon attempt failed.



The status code `0xc000006d` indicates a general logon failure. The event recorded an interactive logon type (2).



The target username and IP address were not available in the collected event fields.



The recorded process path references the Copilot application. This alone does not establish that the application caused the failed login or that malicious activity occurred.



##### **4. Detection Results**



\- Failed login events detected: 1

\- Repeated failures for named accounts: None detected

\- CSV report successfully generated.



##### **5. Conclusion**



One failed login event was identified in the Windows Security log.



Based on the available evidence, the event cannot be classified as malicious. Further investigation would be required to establish its cause and context.



##### **6. Recommended Analyst Actions**



\- Review surrounding Windows Security events.

\- Check related account and authentication activity.

\- Investigate additional failed login attempts if they occur.

\- Monitor for repeated failures or unusual login patterns.



##### **7. Disclaimer**



This investigation was conducted in a personal Windows lab environment for educational purposes. No real-world attack was performed.

