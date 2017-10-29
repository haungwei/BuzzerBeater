package eeit.personaldata.model;

import java.util.List;

public class PersonalDataService {
   private PersonalDataDAO_interface dao;
	
	public PersonalDataService(){
		dao=new PersonalDataDAO();
	}
	//給個人數據的查詢
	public List<PersonalDataVO> getAll(){
		return dao.getAll();
	}
	//給team的查詢
	public List<PersonalDataVO> getAll1(){
		return dao.getAll1();
	}
	//給後台使用PersonalData的新刪修
	public List<PersonalDataVO> getAll2(){
		return dao.getAll2();
	}
}
