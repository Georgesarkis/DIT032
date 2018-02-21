package se.chalmers.dm;

public class User {
	private String ssn;
	private String name;
	private String email;
	private Boolean isActive;
public User (String ssn, String name, String email, Boolean isActive) {
	 this.ssn = ssn;
	 this.name = name;
	 this.email = email;
	 this.isActive = isActive;
 }
 public void setSsn(String ssn) {
	 this.ssn = ssn;
 }
 public void setName(String name) {
	 this.name= name;
 } 
 public void setEmail(String email) {
	 this.email = email;
 }
 public void setIsActive(Boolean isActive) {
	 this.isActive = isActive;
 }
 public String getSsn() {
	return this.ssn;
 }
 public String getName() {
	return this.name;
 }
 public String getEmail() {
	 return this.email;
 }
 public Boolean getIsActive() {
	 return this.isActive;
 }
@Override
public String toString() {
	return "User [ssn=" + ssn + ", name=" + name + ", email=" + email + ", isActive=" + isActive + "]";
}

}
