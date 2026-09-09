// Seed Courses, Contacts, and Enrollments (Day 1, 2, 3, 4 Data)

// 1. Create Courses
Course__c c1 = new Course__c(
    Name = 'Salesforce Admin Fundamentals',
    Description__c = '5-day admin bootcamp for graduation students',
    Status__c = 'Live',
    Fee__c = 15000,
    Start_Date__c = Date.newInstance(2026, 9, 14)
);
Course__c c2 = new Course__c(
    Name = 'Data Analytics 101',
    Description__c = 'Introductory data analytics course',
    Status__c = 'Planned',
    Fee__c = 12000,
    Start_Date__c = Date.newInstance(2026, 9, 14)
);
Course__c c3 = new Course__c(
    Name = 'Cyber Security Intro',
    Description__c = 'Introduction to Cybersecurity concepts and practices',
    Status__c = 'Live',
    Fee__c = 10000,
    Start_Date__c = Date.today()
);
insert new List<Course__c>{ c1, c2, c3 };

// 2. Create Contacts (Students)
Contact p1 = new Contact(
    FirstName = 'Priya',
    LastName = 'Sharma',
    Email = UserInfo.getUserEmail()
);
Contact p2 = new Contact(
    FirstName = 'Rahul',
    LastName = 'Verma',
    Email = UserInfo.getUserEmail()
);
Contact p3 = new Contact(
    FirstName = 'Neha',
    LastName = 'Kumar',
    Email = UserInfo.getUserEmail()
);
insert new List<Contact>{ p1, p2, p3 };

// 3. Create Enrollments
Enrollment__c e1 = new Enrollment__c(
    Course__c = c1.Id,
    Student__c = p1.Id,
    Amount_Paid__c = 15000
);
Enrollment__c e2 = new Enrollment__c(
    Course__c = c1.Id,
    Student__c = p2.Id,
    Amount_Paid__c = 15000
);
Enrollment__c e3 = new Enrollment__c(
    Course__c = c1.Id,
    Student__c = p3.Id,
    Amount_Paid__c = 15000
);
Enrollment__c e4 = new Enrollment__c(
    Course__c = c3.Id,
    Student__c = p1.Id,
    Amount_Paid__c = 10000
);
insert new List<Enrollment__c>{ e1, e2, e3, e4 };

System.debug('=== COACHING CENTRE RECORDS SEEDED SUCCESSFULLY ===');
