🏥 Hospital Management System (HMS)

<img width="1364" height="633" alt="Screenshot 2026-05-07 113808" src="https://github.com/user-attachments/assets/122a218a-e7ec-4950-a680-c7439a4a5dc3" />
<img width="1236" height="629" alt="Doctor" src="https://github.com/user-attachments/assets/063e73f1-aa0e-4988-8805-7b8f10dba48b" />
<img width="1307" height="632" alt="Patient" src="https://github.com/user-attachments/assets/af2ae61f-fec9-464b-bc56-386ebb58164c" />
<img width="1313" height="617" alt="Appointment" src="https://github.com/user-attachments/assets/30fae71a-f1a6-42d0-89e0-6a90076022b3" />
A full-stack Hospital Management System built with ASP.NET Web Forms (C#) and MS SQL Server. The system handles hospital staff login, patient records management, doctor management, and appointment tracking — all through a web-based interface with real-time database connectivity.

🎓 This is my first full-stack web project, demonstrating end-to-end development using ASP.NET, C#, and SQL Server.


🚀 Features

🔐 Staff Login — Role-based login using Mobile Number, Password, and Department selection
🧑‍⚕️ Patient Management — Add, view, edit, and delete patient records with inline GridView editing
👨‍⚕️ Doctor Management — Manage doctor profiles and details
📅 Appointment Scheduling — Book and manage patient appointments
📊 Live Dashboard Counters — Real-time count of total patients and appointments on the dashboard
🔔 SweetAlert Popups — User-friendly success/error notifications using SweetAlert2
🗄️ Full CRUD Operations — Complete Create, Read, Update, Delete across all modules


🛠️ Tech Stack
LayerTechnologyFrontendHTML, CSS, JavaScript, jQuery, BootstrapBackendC#, ASP.NET Web Forms (.aspx)DatabaseMicrosoft SQL Server (MS SQL)IDEVisual StudioAlertsSweetAlert2

📂 Project Structure
Hospital-Management-System-Project/
│
├── HMS_LOGIN.aspx               # Login page UI
├── HMS_LOGIN.aspx.cs            # Login logic — authenticates via Mobile, Password & Department
│
├── PatientDEMO.aspx             # Patient management UI (GridView with inline edit)
├── PatientDEMO.aspx.cs          # Patient CRUD + live patient/appointment counters
│
├── DocterDEMO.aspx              # Doctor management UI
├── DocterDEMO.aspx.cs           # Doctor CRUD logic
│
├── AppointmentDEMO1.aspx        # Appointment booking UI
├── AppointmentDEMO1.aspx.cs     # Appointment CRUD logic
│
├── jquery/                      # jQuery library files
├── Properties/                  # Project assembly properties
│
├── Web.config                   # DB connection string & app config
├── HMS-SYSTEM-29.csproj         # Project file
├── HMS-SYSTEM-29.slnx           # Visual Studio solution file
└── packages.config              # NuGet package references

🗃️ Database Tables
TableDescriptionHMD_DBStaff login credentials (Mobile, Password, Department)Patient_DataPatient records (Name, Age, Gender, Mobile)AppointmentDBAppointment records linked to patients and doctors

⚙️ Installation & Setup
Prerequisites

Visual Studio 2019 / 2022 with ASP.NET workload
SQL Server + SQL Server Management Studio (SSMS)
.NET Framework 4.x

Steps

Clone the repository

bash   git clone https://github.com/shashankdhimann/Hospital-Management-System-Project.git

Open in Visual Studio

Double-click HMS-SYSTEM-29.slnx or open via File → Open → Project/Solution


Set up the Database

Open SSMS and create a new database (e.g., HMS_DB)
Run the following SQL to create the required tables:



sql   -- Staff Login Table
   CREATE TABLE HMD_DB (
       Id INT PRIMARY KEY IDENTITY,
       Mobile VARCHAR(15),
       Pass VARCHAR(50),
       Department VARCHAR(50)
   );

   -- Patient Records Table
   CREATE TABLE Patient_Data (
       Id INT PRIMARY KEY IDENTITY,
       P_Name VARCHAR(100),
       P_Age INT,
       P_Gender VARCHAR(10),
       P_Mobile VARCHAR(15)
   );

   -- Appointments Table
   CREATE TABLE AppointmentDB (
       Id INT PRIMARY KEY IDENTITY,
       Patient_Name VARCHAR(100),
       Doctor_Name VARCHAR(100),
       Appointment_Date DATE
   );

Configure the Connection String

Open Web.config and update with your SQL Server details:



xml   <connectionStrings>
     <add name="DBCSL"
          connectionString="Data Source=YOUR_SERVER;Initial Catalog=HMS_DB;Integrated Security=True"
          providerName="System.Data.SqlClient" />
     <add name="BDCSP"
          connectionString="Data Source=YOUR_SERVER;Initial Catalog=HMS_DB;Integrated Security=True"
          providerName="System.Data.SqlClient" />
   </connectionStrings>

Run the Project

Press F5 or click ▶ Start in Visual Studio
The app opens at https://localhost:xxxx/HMS_LOGIN.aspx




📸 Screenshots

(Add screenshots of your Login Page, Patient Dashboard, Doctor Panel, and Appointment Page here)
<img width="1364" height="633" alt="Screenshot 2026-05-07 113808" src="https://github.com/user-attachments/assets/122a218a-e7ec-4950-a680-c7439a4a5dc3" />
<img width="1236" height="629" alt="Doctor" src="https://github.com/user-attachments/assets/063e73f1-aa0e-4988-8805-7b8f10dba48b" />
<img width="1307" height="632" alt="Patient" src="https://github.com/user-attachments/assets/af2ae61f-fec9-464b-bc56-386ebb58164c" />
<img width="1313" height="617" alt="Appointment" src="https://github.com/user-attachments/assets/30fae71a-f1a6-42d0-89e0-6a90076022b3" />

Login PagePatient Dashboardscreenshots/login.pngscreenshots/patient.png

🔐 Security Note

⚠️ The current login stores passwords as plain text. In production, passwords should be hashed using BCrypt or ASP.NET Identity. This project is for learning purposes and security hardening is planned as a future improvement.


🔮 Future Improvements

 Password hashing (BCrypt / ASP.NET Identity)
 Role-based access control (Admin, Doctor, Receptionist)
 Appointment status tracking (Pending / Confirmed / Cancelled)
 Patient medical history & diagnosis records
 Doctor availability and schedule management
 Bill generation and payment tracking
 Analytics dashboard with charts
 Cloud deployment (Azure App Service)


🤝 Contributing
Contributions are welcome!

Fork the repository
Create a branch: git checkout -b feature/your-feature
Commit your changes: git commit -m "Add your feature"
Push: git push origin feature/your-feature
Open a Pull Request


📄 License
This project is open-source under the MIT License.

👨‍💻 Author
Shashank Dhiman

⭐ If you found this project useful, consider giving it a star!
