package com.app;

public class AppDTO {

	// booking ���̺�
	private String id, bdate, checkIn, checkOut, content, subject;
	// ���̵�,���೯¥,�Խǳ�¥,��ǳ�¥,����,����
	private int status, total, hitCount, bnum;
	// ���¿���,�ѱݾ�,��ȸ��,�����ȣ
	private String name;
	// ������̺� �����ؼ� name���� ����..

	// serviceDe ���̺�, bookingDe ���̺�
	private String ssnum, bsnum, payOpt;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// ���񽺻󼼹�ȣ, ����󼼹�ȣ, �������
	private int pay;
	// �����ݾ�

	public String getId() {
		return id;
	}

	public String getSsnum() {
		return ssnum;
	}

	public void setSsnum(String ssnum) {
		this.ssnum = ssnum;
	}

	public String getBsnum() {
		return bsnum;
	}

	public void setBsnum(String bsnum) {
		this.bsnum = bsnum;
	}

	public String getPayOpt() {
		return payOpt;
	}

	public void setPayOpt(String payOpt) {
		this.payOpt = payOpt;
	}

	public int getPay() {
		return pay;
	}

	public void setPay(int pay) {
		this.pay = pay;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBdate() {
		return bdate;
	}

	public void setBdate(String bdate) {
		this.bdate = bdate;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getHitCount() {
		return hitCount;
	}

	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}

	public int getBnum() {
		return bnum;
	}

	public void setBnum(int bnum) {
		this.bnum = bnum;
	}

}
