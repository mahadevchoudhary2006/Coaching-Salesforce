// Create Trainer One user and assign Trainer Profile, Role, and Permission Set
Profile p = [SELECT Id FROM Profile WHERE Name = 'Trainer' LIMIT 1];
UserRole r = [SELECT Id FROM UserRole WHERE DeveloperName = 'Trainer' LIMIT 1];

String orgDomain = [SELECT Id FROM Organization LIMIT 1].Id.toLowerCase();
String uniqueUsername = 'trainer.one.' + orgDomain + '@dev.salesforce.com';

List<User> existing = [SELECT Id FROM User WHERE Username = :uniqueUsername];
if (existing.isEmpty()) {
    User u = new User(
        FirstName = 'Trainer',
        LastName = 'One',
        Alias = 'trone',
        Email = UserInfo.getUserEmail(),
        Username = uniqueUsername,
        ProfileId = p.Id,
        UserRoleId = r.Id,
        TimeZoneSidKey = 'Asia/Kolkata',
        LocaleSidKey = 'en_IN',
        LanguageLocaleKey = 'en_US',
        EmailEncodingKey = 'UTF-8'
    );
    insert u;
    System.setPassword(u.Id, 'Salesforce@6376');

    PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'View_Course_Fee' LIMIT 1];
    insert new PermissionSetAssignment(
        AssigneeId = u.Id,
        PermissionSetId = ps.Id
    );
    System.debug('=== TRAINER ONE CREATED: ' + u.Username + ' ===');
} else {
    System.debug('=== TRAINER USER ALREADY EXISTS ===');
}
