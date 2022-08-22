/**
 * An apex page controller that exposes the change password functionality
 */
@IsTest public with sharing class ChangePasswordControllerTest {
    @IsTest(SeeAllData=true) 
    public static void testChangePasswordController() {
        // Instantiate a new controller with all parameters in the page
        ChangePasswordController controller = new ChangePasswordController();
        List<contact> conlist = new List<contact>();
        conlist = [Select id,name, Email,Portal_password__c from contact Limit 1]; 
        Contact con = new contact();
        controller.oldPassword = '123456';
        controller.newPassword = 'qwerty1'; 
        controller.verifyNewPassword = 'qwerty1';                
        //controller.Email ='asd@gmail.com';
       // controller.name = 'varma';
        controller.changePassword();
        PageReference pageRef = Page.ChangePasswordConfirmation3;
        Test.setCurrentPage(pageRef);
       // System.assertEquals(controller.changePassword(),null);                           
    }    
}