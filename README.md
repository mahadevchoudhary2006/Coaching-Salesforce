# Coaching Centre Salesforce Solution 🎓

An end-to-end, production-ready Coaching Centre Management application built on the Salesforce Platform using Salesforce DX (SFDX). Designed to track courses, manage student enrollments, enforce role-based access security, automate onboarding workflows, and visualize real-time enrollment analytics.

---

## 🏗️ Architecture & Features

### 1. Data Model
* **`Course__c` (Custom Object)**: Tracks course offerings.
  * Fields: `Description__c`, `Status__c` (`Planned`, `Live`, `Completed`), `Fee__c`, `Start_Date__c`.
  * **Roll-up Summaries**:
    * `Total_Enrollments__c`: Real-time `COUNT` of student enrollments.
    * `Total_Revenue__c`: Real-time `SUM` of amount paid.
* **`Enrollment__c` (Custom Object - Master-Detail)**: Represents a student enrollment in a course.
  * Auto-Number Name: `ENR-{0000}`.
  * Fields: `Course__c` (Master-Detail), `Student__c` (Lookup to standard `Contact`), `Amount_Paid__c` (Currency).

### 2. Security & Access Control
* **Organization-Wide Defaults (OWD)**: `Course__c` set to **Private**.
* **Role Hierarchy**: `Trainer Manager` reporting to `CEO`; `Trainer` reporting to `Trainer Manager`.
* **Criteria-Based Sharing Rule**: Automatically shares courses where `Status__c = 'Live'` with users having the `Trainer` role with **Read/Write** permissions.
* **Field-Level Security & Permission Sets**:
  * `Fee__c` field hidden by default on the `Trainer` profile.
  * `View_Course_Fee` Permission Set grants selective visibility to course fees.
  * `Coaching_Admin_Access` Permission Set grants full tab visibility for Admins.

### 3. Workflow Automation (Salesforce Flow)
* **`Enrollment_Welcome` (Record-Triggered Flow)**: Triggers automatically whenever a new `Enrollment__c` record is created:
  1. Sends an automated, personalized welcome email to the enrolled student Contact.
  2. Creates a follow-up Task for the instructor: *"Call new student to confirm schedule and answer questions"*.
  3. Automatically updates the parent `Course__c` status from `Planned` to `Live`.

### 4. Reports & Dashboards
* **Custom Report Type**: `Courses with Enrollments` (`Courses_with_Enrollments__c`).
* **Reports** (Saved in `Coaching Reports` folder):
  1. **All Enrollments** (`Tabular`): Lists enrollment numbers, course names, student contacts, payment amounts, and enrollment dates.
  2. **Enrollments by Course** (`Summary`): Groups enrollments by Course with subtotaled revenue and record count.
  3. **Enrollments by Course and Month** (`Matrix`): Matrix view grouped by Course (rows) and Calendar Month (columns).
* **Dashboard** (Saved in `Coaching Dashboards` folder):
  * **Enrollments Dashboard**:
    * **Revenue by Course**: Vertical Column chart comparing revenue generated per course.
    * **Enrollments by Course**: Donut chart displaying student share across courses.

---

## 🚀 Setup Instructions for Another Salesforce Account

You can deploy this entire solution to any new or existing Salesforce Developer Edition, Scratch Org, or Sandbox in **under 3 minutes** using the Salesforce CLI (`sf`).

### Prerequisites
1. **Salesforce CLI** installed: [Install CLI](https://developer.salesforce.com/tools/salesforcecli)
2. Verify installation:
   ```bash
   sf --version
   ```

---

### Step 1: Clone the Repository
```bash
git clone https://github.com/mahadevchoudhary2006/Coaching-Salesforce.git
cd Coaching-Salesforce
```

---

### Step 2: Authenticate the Target Salesforce Org
Log into the destination Salesforce account and assign it an alias (e.g., `my-coaching-org`):
```bash
sf org login web -a my-coaching-org
```
*Your default browser will open. Log into your Salesforce account and click **Allow**.*

Set it as your default org (optional):
```bash
sf config set target-org=my-coaching-org
```

---

### Step 3: Deploy All Metadata (1 Command)
Deploy all objects, fields, tabs, flows, security rules, reports, and dashboards:
```bash
sf project deploy start -o my-coaching-org
```

---

### Step 4: Seed Sample Records (1 Command)
Populate sample courses, student contacts, and enrollments:
```bash
sf apex run -f scripts/apex/seed_records.apex -o my-coaching-org
```
*This creates:*
* *Courses: `Salesforce Admin Fundamentals`, `Data Analytics 101`, `Cyber Security Intro`*
* *Students: `Priya Sharma`, `Rahul Verma`, `Neha Kumar`*
* *Enrollments: Total revenue ₹55,000 across 4 enrollments.*

---

### Step 5 (Optional): Provision Trainer User & Permissions
To test trainer login and role-based sharing:
```bash
sf apex run -f scripts/apex/create_trainer_user.apex -o my-coaching-org
```

---

## 🔍 Verification & Testing Checklist

1. **Verify Custom Tabs**:
   * Open the App Launcher (nine dots icon) in Salesforce and search for **Courses** and **Enrollments**.
   * Switch the list view to **All Courses** and pin it.
2. **Verify Automation Flow**:
   * Create a new course with `Status__c = 'Planned'`.
   * Create a new Enrollment record under it.
   * Notice that the Course status automatically flips to `Live`, a task is created, and an email is dispatched.
3. **Verify Reports & Dashboard**:
   * Navigate to the **Reports** tab and open the **Coaching Reports** folder.
   * Navigate to the **Dashboards** tab and open **Enrollments Dashboard**.

---

## 📂 Project Structure
```
Coaching-Salesforce/
├── force-app/main/default/
│   ├── dashboards/            # Coaching Dashboards & metadata
│   ├── flows/                 # Enrollment_Welcome Record-Triggered Flow
│   ├── objects/               # Course__c and Enrollment__c objects & fields
│   ├── permissionsets/        # View_Course_Fee & Admin permissions
│   ├── profiles/              # Trainer custom profile
│   ├── reportTypes/           # Courses with Enrollments report type
│   ├── reports/               # Coaching Reports (Tabular, Summary, Matrix)
│   ├── roles/                 # Trainer & Trainer Manager roles
│   ├── sharingRules/          # Course__c criteria-based sharing rules
│   └── tabs/                  # Custom Object tabs
├── scripts/apex/
│   ├── seed_records.apex      # Apex data generator for courses & enrollments
│   └── create_trainer_user.apex # Apex script to provision trainer user
├── sfdx-project.json          # Salesforce DX project definition
└── README.md                  # Complete documentation and setup guide
```

---

## 👤 Author
**Mahadev Choudhary**
* GitHub: [@mahadevchoudhary2006](https://github.com/mahadevchoudhary2006)
