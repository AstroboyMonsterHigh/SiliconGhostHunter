# 👻 Silicon Ghost-Hunter: Chrome Gemini Nano Audit

> **"If you aren't auditing your environment, you don't own it."**

`Silicon Ghost-Hunter` is a lightweight, forensic zsh utility designed for Apple Silicon (M-series) users. It investigates the silent, background deployment of Google’s **Gemini Nano AI**—a 4GB Large Language Model (LLM) currently being pushed to Chrome 148+ browsers without explicit user consent.

---

## 🔍 Why This Exists: The "Ghost" in the Machine

Starting in May 2026, Google Chrome began a silent rollout of **Gemini Nano** to eligible desktop devices. While on-device AI offers privacy benefits, the deployment process raises significant concerns for power users and security professionals:

* **Shadow Resource Allocation:** On Apple M-series chips, RAM is **Unified**. A 4GB AI model isn't just sitting on your disk; it effectively "reserves" a massive chunk of your potential VRAM when active, impacting your creative and development workflows.
* **Expanding the Attack Surface:** Every gigabyte of unauthorized binary code added to your system is a new potential vector for exploitation. Silent downloads bypass the **Principle of Least Privilege**.
* **The "Re-Download" Loop:** Deleting the files manually often fails. Chrome's "Optimization Guide" is designed to silently re-fetch these weights unless a hardware-level or policy-level block is established.

---

## 🛠️ What This Script Audits

This tool performs a **Linear Force-Scan** of your system, ensuring no artifacts are missed:

1.  **Architecture Verification:** Confirms Apple Silicon (arm64) status to assess high-priority target risk.
2.  **Chrome Bundle Audit:** Scans all installed Chrome versions for eligibility (v148+).
3.  **Binary Forensics:** Brute-force searches `~/Library` for the `weights.bin` payload (approx. 4GB).
4.  **Live Memory Analysis:** Sniffs active processes for `OptimizationGuide` or `Gemini` hooks.
5.  **Policy Registry Check:** Verifies if an administrative block (`GenAILocalFoundationalModelSettings`) is active.

---

## 🚀 Quick Start

Ensure you are using a terminal that supports ZSH (Standard on macOS).

### **1. Clone the Repo**
```zsh
git clone https://github.com/YOUR_USERNAME/SiliconGhostHunter.git
cd SiliconGhostHunter
```

### **2. Set Permissions**
```zsh
chmod +x hunt_nano.sh
```

### **3. Run the Audit**
```zsh
./hunt_nano.sh
```

---

## 🛡️ The "Human Firewall" Philosophy

This project is built on the belief that **Digital Fitness** requires the same discipline as physical training. 

* **Audit Regularly:** Don't let background processes become "Technical Debt."
* **Monitor Your Macros:** In this case, your "macros" are your Unified Memory and Disk I/O.
* **Stay Investigative:** If a multi-gigabyte file appears on your drive without a prompt, treat it as a "Digital Intrusion" until verified.

> ### **Did You Know?**
> On M-series Macs, the **Apple Neural Engine (ANE)** is often the target for these models. Running this script is the first step in ensuring your NPU isn't being used as a "Distributed Computing Node" for a corporation without your knowledge.

---

## ⚖️ License
Distributed under the **MIT License**. See `LICENSE` for more information.

---

**Thinking Question for Users:**
*If a browser can silently download and execute a 4GB binary today, what will it feel entitled to download tomorrow?* ---

### **Contributor Tips**
If you find a new path where Chrome is hiding its `weights.bin` on macOS, please open an **Issue** or a **Pull Request**! Keep the ghost-hunting community strong.
