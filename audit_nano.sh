#!/bin/zsh

# --- Styling & Variables ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Helper for interactive pauses
step_pause() { sleep 0.8; }

clear
echo -e "${CYAN}${BOLD}"
echo "=========================================================="
echo "      SILICON GHOST-HUNTER: GEMINI NANO AUDIT v1.5        "
echo "        DETECTION MODE: FORCED | TARGET: CHROME 148+      "
echo "=========================================================="
echo -e "${NC}"

# --- STEP 1: SILICON HARDWARE AUDIT ---
echo -e "${BOLD}[1/5] HARDWARE ARCHITECTURE PROBE${NC}"
echo -e "Command: ${YELLOW}sysctl -n machdep.cpu.brand_string${NC}"
echo "Description: Verifying if the CPU has the Integrated Neural Engine/Unified Memory for AI."
step_pause
CPU_INFO=$(sysctl -n machdep.cpu.brand_string)
if [[ $CPU_INFO == *"Apple M"* ]]; then
    echo -e "${GREEN}[CLEARED] Detected: $CPU_INFO. High-performance AI target.${NC}\n"
else
    echo -e "${YELLOW}[INFO] Detected: $CPU_INFO. Non-M-Series may be lower priority for rollout.${NC}\n"
fi

# --- STEP 2: CHROME VERSIONING & PATHS ---
echo -e "${BOLD}[2/5] APPLICATION SCOPE AUDIT${NC}"
echo -e "Command: ${YELLOW}mdfind \"kMDItemCFBundleIdentifier == 'com.google.Chrome'\"${NC}"
echo "Description: Locating every Chrome installation to check for version 148+ eligibility."
step_pause
CHROME_PATHS=$(mdfind "kMDItemCFBundleIdentifier == 'com.google.Chrome'")

if [[ -z "$CHROME_PATHS" ]]; then
    echo -e "${GREEN}[CLEARED] No Chrome installations found on this system.${NC}\n"
else
    while read -r path; do
        VERSION=$("$path/Contents/MacOS/Google Chrome" --version 2>/dev/null)
        echo -e "Found: $path | ${CYAN}$VERSION${NC}"
        if [[ $VERSION == *" 148."* ]] || [[ $VERSION == *" 149."* ]]; then
            echo -e "${RED}[WARNING] Version is within the 148+ Silent Deployment window!${NC}"
        fi
    done <<< "$CHROME_PATHS"
    echo ""
fi

# --- STEP 3: FORENSIC DISK SCAN ---
echo -e "${BOLD}[3/5] BINARY SIGNATURE FORENSICS${NC}"
echo -e "Command: ${YELLOW}find ~/Library -name \"weights.bin\"${NC}"
echo "Description: Brute-force searching Application Support for the 4GB LLM payload."
step_pause
SEARCH_ROOT="$HOME/Library/Application Support/Google/Chrome"
WEIGHTS_FOUND=$(find "$SEARCH_ROOT" -name "weights.bin" -exec du -h {} + 2>/dev/null)

if [[ -n "$WEIGHTS_FOUND" ]]; then
    echo -e "${RED}[WARNING] PAYLOAD DETECTED!${NC}"
    echo -e "${YELLOW}$WEIGHTS_FOUND${NC}\n"
else
    echo -e "${GREEN}[CLEARED] No 'weights.bin' detected in the local user profile.${NC}\n"
fi

# --- STEP 4: LIVE MEMORY & PROCESS ANALYSIS ---
echo -e "${BOLD}[4/5] BEHAVIORAL PROCESS MONITORING${NC}"
echo -e "Command: ${YELLOW}ps aux | grep -Ei \"OptimizationGuide|Gemini\"${NC}"
echo "Description: Checking if the Chrome AI engine is currently resident in RAM."
step_pause
# Filter out the grep command itself
PROC_HUNT=$(ps aux | grep -Ei "OptimizationGuide|Gemini" | grep -v grep)

if [[ -n "$PROC_HUNT" ]]; then
    echo -e "${RED}[WARNING] ACTIVE AI PROCESSES IDENTIFIED:${NC}"
    echo -e "$PROC_HUNT\n"
else
    echo -e "${GREEN}[CLEARED] No active Gemini/Optimization processes currently running.${NC}\n"
fi

# --- STEP 5: DEFENSE POSTURE CHECK ---
echo -e "${BOLD}[5/5] ENTERPRISE POLICY AUDIT${NC}"
echo -e "Command: ${YELLOW}defaults read com.google.Chrome GenAILocalFoundationalModelSettings${NC}"
echo "Description: Checking for the 'Human Firewall' override policy."
step_pause
POLICY_CHECK=$(defaults read com.google.Chrome GenAILocalFoundationalModelSettings 2>/dev/null)

if [[ "$POLICY_CHECK" == "1" ]]; then
    echo -e "${GREEN}[CLEARED] Block Policy is ACTIVE. Chrome is restricted from downloading the model.${NC}\n"
else
    echo -e "${RED}[WARNING] No Block Policy set. System is open to silent AI deployment.${NC}\n"
fi

# --- FINAL SUMMARY ---
echo -e "${CYAN}${BOLD}=========================================================="
echo "                  AUDIT COMPLETE SUMMARY                  "
echo -e "==========================================================${NC}"
if [[ -n "$WEIGHTS_FOUND" ]] || [[ "$POLICY_CHECK" != "1" ]]; then
    echo -e "${RED}STATUS: VULNERABLE / BLOATED${NC}"
    echo "Your silicon is currently a host for silent binaries or has no defenses in place."
else
    echo -e "${GREEN}STATUS: HARDENED / CLEAN${NC}"
    echo "Your environment is free of unverified 4GB AI payloads."
fi
echo -e "${CYAN}==========================================================${NC}\n"

# --- Behavioral Insight ---
echo -e "${YELLOW}${BOLD}Did you know?${NC}"
echo "On Apple Silicon, RAM is 'Unified.' When Chrome pulls this 4GB model, it isn't just taking disk space; it is reserving 4GB of your memory pool, reducing the VRAM available for your own builds and creative work. This is a form of 'Shadow Resource Allocation.'"

