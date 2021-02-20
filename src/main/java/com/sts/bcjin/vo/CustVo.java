package com.sts.bcjin.vo;

import java.util.ArrayList;
import java.util.HashMap;

public class CustVo {
	String custNo;
	String custType;
	String custRegDate;
	String custRegPerson;
	String custName;
	String custNameShort;
	String custAddr;
	String custHomepage;
	String custMemo;
	String custCreateTime;
	String custUpdateTime;
	
	String manCustNo;
	int manSeq;
	String manName;
	String manTel;
	String manEmail;
	String manJob;
	
	ArrayList<HashMap<String, Object>> info;

	public String getCustNo() {
		return custNo;
	}

	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}

	public String getCustType() {
		return custType;
	}

	public void setCustType(String custType) {
		this.custType = custType;
	}

	public String getCustRegDate() {
		return custRegDate;
	}

	public void setCustRegDate(String custRegDate) {
		this.custRegDate = custRegDate;
	}

	public String getCustRegPerson() {
		return custRegPerson;
	}

	public void setCustRegPerson(String custRegPerson) {
		this.custRegPerson = custRegPerson;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getCustNameShort() {
		return custNameShort;
	}

	public void setCustNameShort(String custNameShort) {
		this.custNameShort = custNameShort;
	}

	public String getCustAddr() {
		return custAddr;
	}

	public void setCustAddr(String custAddr) {
		this.custAddr = custAddr;
	}

	public String getCustHomepage() {
		return custHomepage;
	}

	public void setCustHomepage(String custHomepage) {
		this.custHomepage = custHomepage;
	}

	public String getCustMemo() {
		return custMemo;
	}

	public void setCustMemo(String custMemo) {
		this.custMemo = custMemo;
	}

	public String getCustCreateTime() {
		return custCreateTime;
	}

	public void setCustCreateTime(String custCreateTime) {
		this.custCreateTime = custCreateTime;
	}

	public String getCustUpdateTime() {
		return custUpdateTime;
	}

	public void setCustUpdateTime(String custUpdateTime) {
		this.custUpdateTime = custUpdateTime;
	}

	public String getManCustNo() {
		return manCustNo;
	}

	public void setManCustNo(String manCustNo) {
		this.manCustNo = manCustNo;
	}

	public int getManSeq() {
		return manSeq;
	}

	public void setManSeq(int manSeq) {
		this.manSeq = manSeq;
	}

	public String getManName() {
		return manName;
	}

	public void setManName(String manName) {
		this.manName = manName;
	}

	public String getManTel() {
		return manTel;
	}

	public void setManTel(String manTel) {
		this.manTel = manTel;
	}

	public String getManEmail() {
		return manEmail;
	}

	public void setManEmail(String manEmail) {
		this.manEmail = manEmail;
	}

	public String getManJob() {
		return manJob;
	}

	public void setManJob(String manJob) {
		this.manJob = manJob;
	}

	public ArrayList<HashMap<String, Object>> getInfo() {
		return info;
	}

	public void setInfo(ArrayList<HashMap<String, Object>> info) {
		this.info = info;
	}

	@Override
	public String toString() {
		return "CustVo [custNo=" + custNo + ", custType=" + custType + ", custRegDate=" + custRegDate
				+ ", custRegPerson=" + custRegPerson + ", custName=" + custName + ", custNameShort=" + custNameShort
				+ ", custAddr=" + custAddr + ", custHomepage=" + custHomepage + ", custMemo=" + custMemo
				+ ", custCreateTime=" + custCreateTime + ", custUpdateTime=" + custUpdateTime + ", manCustNo="
				+ manCustNo + ", manSeq=" + manSeq + ", manName=" + manName + ", manTel=" + manTel + ", manEmail="
				+ manEmail + ", manJob=" + manJob + ", info=" + info + "]";
	}
	
	
	
}
