/**
 * 2013 MoneyCollectRptDto.java Licensed to Steven J.S Min. For use this source code, you must have to get right from the author. Unless enforcement
 * is prohibited by applicable law, you may not modify, decompile, or reverse engineer Software.
 */
package com.photome.dto;

import com.cosmos.common.dto.BaseDto;

/**
 * @author Steven J.S Min
 * 
 */
public class MoneyCollectRptDto extends BaseDto {

	private String rptKey;

	private BoothDto boothDto;
	private BoothGroupDto boothGroupDto;

	// 월별 수금금액
	private String collectAmt01;
	private String collectAmt02;
	private String collectAmt03;
	private String collectAmt04;
	private String collectAmt05;
	private String collectAmt06;
	private String collectAmt07;
	private String collectAmt08;
	private String collectAmt09;
	private String collectAmt10;
	private String collectAmt11;
	private String collectAmt12;

	// 분기별 수금금액
	private String collectAmtQ1;
	private String collectAmtQ2;
	private String collectAmtQ3;
	private String collectAmtQ4;

	// 월별 환불금액
	private String refundAmt01;
	private String refundAmt02;
	private String refundAmt03;
	private String refundAmt04;
	private String refundAmt05;
	private String refundAmt06;
	private String refundAmt07;
	private String refundAmt08;
	private String refundAmt09;
	private String refundAmt10;
	private String refundAmt11;
	private String refundAmt12;

	// 분기별 환불금액
	private String refundAmtQ1;
	private String refundAmtQ2;
	private String refundAmtQ3;
	private String refundAmtQ4;

	// 월별 렌트비용
	private String rentFeeAmt01;
	private String rentFeeAmt02;
	private String rentFeeAmt03;
	private String rentFeeAmt04;
	private String rentFeeAmt05;
	private String rentFeeAmt06;
	private String rentFeeAmt07;
	private String rentFeeAmt08;
	private String rentFeeAmt09;
	private String rentFeeAmt10;
	private String rentFeeAmt11;
	private String rentFeeAmt12;

	// 분기별 렌트비용
	private String rentFeeAmtQ1;
	private String rentFeeAmtQ2;
	private String rentFeeAmtQ3;
	private String rentFeeAmtQ4;

	// 월별 비용이 찾이하는 비율
	private String rateOfExpense01;
	private String rateOfExpense02;
	private String rateOfExpense03;
	private String rateOfExpense04;
	private String rateOfExpense05;
	private String rateOfExpense06;
	private String rateOfExpense07;
	private String rateOfExpense08;
	private String rateOfExpense09;
	private String rateOfExpense10;
	private String rateOfExpense11;
	private String rateOfExpense12;

	// 분기별 비용이 찾이하는 비율
	private String rateOfExpenseQ1;
	private String rateOfExpenseQ2;
	private String rateOfExpenseQ3;
	private String rateOfExpenseQ4;

	// 월별 이익율
	private String rateOfReturn01;
	private String rateOfReturn02;
	private String rateOfReturn03;
	private String rateOfReturn04;
	private String rateOfReturn05;
	private String rateOfReturn06;
	private String rateOfReturn07;
	private String rateOfReturn08;
	private String rateOfReturn09;
	private String rateOfReturn10;
	private String rateOfReturn11;
	private String rateOfReturn12;

	// 분기별 이익율
	private String rateOfReturnQ1;
	private String rateOfReturnQ2;
	private String rateOfReturnQ3;
	private String rateOfReturnQ4;

	// 총계
	private String collectAmtTot;
	private String refundAmtTot;
	private String rentFeeAmtTot;

	private String rateOfExpenseTot; // (비용5/매출)*100 : 값이 높을수록 비용이 많이 든다(즉, 수익률이 좋지 않음을 의미)
	private String rateOfReturnTot; // 수익률 : (매출-비용)*(1/100) : 숫자가 높으면 수익률이 좋다는 의미(마이너스(-1)인경우 '손실 > 이익'의 의미이다.

	public String getRptKey() {
		return rptKey;
	}

	public void setRptKey(String rptKey) {
		this.rptKey = rptKey;
	}

	public BoothGroupDto getBoothGroupDto() {
		return boothGroupDto;
	}

	public void setBoothGroupDto(BoothGroupDto boothGroupDto) {
		this.boothGroupDto = boothGroupDto;
	}

	public BoothDto getBoothDto() {
		return boothDto;
	}

	public void setBoothDto(BoothDto boothDto) {
		this.boothDto = boothDto;
	}

	public String getCollectAmt01() {
		return collectAmt01;
	}

	public void setCollectAmt01(String collectAmt01) {
		this.collectAmt01 = collectAmt01;
	}

	public String getCollectAmt02() {
		return collectAmt02;
	}

	public void setCollectAmt02(String collectAmt02) {
		this.collectAmt02 = collectAmt02;
	}

	public String getCollectAmt03() {
		return collectAmt03;
	}

	public void setCollectAmt03(String collectAmt03) {
		this.collectAmt03 = collectAmt03;
	}

	public String getCollectAmt04() {
		return collectAmt04;
	}

	public void setCollectAmt04(String collectAmt04) {
		this.collectAmt04 = collectAmt04;
	}

	public String getCollectAmt05() {
		return collectAmt05;
	}

	public void setCollectAmt05(String collectAmt05) {
		this.collectAmt05 = collectAmt05;
	}

	public String getCollectAmt06() {
		return collectAmt06;
	}

	public void setCollectAmt06(String collectAmt06) {
		this.collectAmt06 = collectAmt06;
	}

	public String getCollectAmt07() {
		return collectAmt07;
	}

	public void setCollectAmt07(String collectAmt07) {
		this.collectAmt07 = collectAmt07;
	}

	public String getCollectAmt08() {
		return collectAmt08;
	}

	public void setCollectAmt08(String collectAmt08) {
		this.collectAmt08 = collectAmt08;
	}

	public String getCollectAmt09() {
		return collectAmt09;
	}

	public void setCollectAmt09(String collectAmt09) {
		this.collectAmt09 = collectAmt09;
	}

	public String getCollectAmt10() {
		return collectAmt10;
	}

	public void setCollectAmt10(String collectAmt10) {
		this.collectAmt10 = collectAmt10;
	}

	public String getCollectAmt11() {
		return collectAmt11;
	}

	public void setCollectAmt11(String collectAmt11) {
		this.collectAmt11 = collectAmt11;
	}

	public String getCollectAmt12() {
		return collectAmt12;
	}

	public void setCollectAmt12(String collectAmt12) {
		this.collectAmt12 = collectAmt12;
	}

	public String getCollectAmtQ1() {
		return collectAmtQ1;
	}

	public void setCollectAmtQ1(String collectAmtQ1) {
		this.collectAmtQ1 = collectAmtQ1;
	}

	public String getCollectAmtQ2() {
		return collectAmtQ2;
	}

	public void setCollectAmtQ2(String collectAmtQ2) {
		this.collectAmtQ2 = collectAmtQ2;
	}

	public String getCollectAmtQ3() {
		return collectAmtQ3;
	}

	public void setCollectAmtQ3(String collectAmtQ3) {
		this.collectAmtQ3 = collectAmtQ3;
	}

	public String getCollectAmtQ4() {
		return collectAmtQ4;
	}

	public void setCollectAmtQ4(String collectAmtQ4) {
		this.collectAmtQ4 = collectAmtQ4;
	}

	public String getRefundAmt01() {
		return refundAmt01;
	}

	public void setRefundAmt01(String refundAmt01) {
		this.refundAmt01 = refundAmt01;
	}

	public String getRefundAmt02() {
		return refundAmt02;
	}

	public void setRefundAmt02(String refundAmt02) {
		this.refundAmt02 = refundAmt02;
	}

	public String getRefundAmt03() {
		return refundAmt03;
	}

	public void setRefundAmt03(String refundAmt03) {
		this.refundAmt03 = refundAmt03;
	}

	public String getRefundAmt04() {
		return refundAmt04;
	}

	public void setRefundAmt04(String refundAmt04) {
		this.refundAmt04 = refundAmt04;
	}

	public String getRefundAmt05() {
		return refundAmt05;
	}

	public void setRefundAmt05(String refundAmt05) {
		this.refundAmt05 = refundAmt05;
	}

	public String getRefundAmt06() {
		return refundAmt06;
	}

	public void setRefundAmt06(String refundAmt06) {
		this.refundAmt06 = refundAmt06;
	}

	public String getRefundAmt07() {
		return refundAmt07;
	}

	public void setRefundAmt07(String refundAmt07) {
		this.refundAmt07 = refundAmt07;
	}

	public String getRefundAmt08() {
		return refundAmt08;
	}

	public void setRefundAmt08(String refundAmt08) {
		this.refundAmt08 = refundAmt08;
	}

	public String getRefundAmt09() {
		return refundAmt09;
	}

	public void setRefundAmt09(String refundAmt09) {
		this.refundAmt09 = refundAmt09;
	}

	public String getRefundAmt10() {
		return refundAmt10;
	}

	public void setRefundAmt10(String refundAmt10) {
		this.refundAmt10 = refundAmt10;
	}

	public String getRefundAmt11() {
		return refundAmt11;
	}

	public void setRefundAmt11(String refundAmt11) {
		this.refundAmt11 = refundAmt11;
	}

	public String getRefundAmt12() {
		return refundAmt12;
	}

	public void setRefundAmt12(String refundAmt12) {
		this.refundAmt12 = refundAmt12;
	}

	public String getRefundAmtQ1() {
		return refundAmtQ1;
	}

	public void setRefundAmtQ1(String refundAmtQ1) {
		this.refundAmtQ1 = refundAmtQ1;
	}

	public String getRefundAmtQ2() {
		return refundAmtQ2;
	}

	public void setRefundAmtQ2(String refundAmtQ2) {
		this.refundAmtQ2 = refundAmtQ2;
	}

	public String getRefundAmtQ3() {
		return refundAmtQ3;
	}

	public void setRefundAmtQ3(String refundAmtQ3) {
		this.refundAmtQ3 = refundAmtQ3;
	}

	public String getRefundAmtQ4() {
		return refundAmtQ4;
	}

	public void setRefundAmtQ4(String refundAmtQ4) {
		this.refundAmtQ4 = refundAmtQ4;
	}

	public String getRentFeeAmt01() {
		return rentFeeAmt01;
	}

	public void setRentFeeAmt01(String rentFeeAmt01) {
		this.rentFeeAmt01 = rentFeeAmt01;
	}

	public String getRentFeeAmt02() {
		return rentFeeAmt02;
	}

	public void setRentFeeAmt02(String rentFeeAmt02) {
		this.rentFeeAmt02 = rentFeeAmt02;
	}

	public String getRentFeeAmt03() {
		return rentFeeAmt03;
	}

	public void setRentFeeAmt03(String rentFeeAmt03) {
		this.rentFeeAmt03 = rentFeeAmt03;
	}

	public String getRentFeeAmt04() {
		return rentFeeAmt04;
	}

	public void setRentFeeAmt04(String rentFeeAmt04) {
		this.rentFeeAmt04 = rentFeeAmt04;
	}

	public String getRentFeeAmt05() {
		return rentFeeAmt05;
	}

	public void setRentFeeAmt05(String rentFeeAmt05) {
		this.rentFeeAmt05 = rentFeeAmt05;
	}

	public String getRentFeeAmt06() {
		return rentFeeAmt06;
	}

	public void setRentFeeAmt06(String rentFeeAmt06) {
		this.rentFeeAmt06 = rentFeeAmt06;
	}

	public String getRentFeeAmt07() {
		return rentFeeAmt07;
	}

	public void setRentFeeAmt07(String rentFeeAmt07) {
		this.rentFeeAmt07 = rentFeeAmt07;
	}

	public String getRentFeeAmt08() {
		return rentFeeAmt08;
	}

	public void setRentFeeAmt08(String rentFeeAmt08) {
		this.rentFeeAmt08 = rentFeeAmt08;
	}

	public String getRentFeeAmt09() {
		return rentFeeAmt09;
	}

	public void setRentFeeAmt09(String rentFeeAmt09) {
		this.rentFeeAmt09 = rentFeeAmt09;
	}

	public String getRentFeeAmt10() {
		return rentFeeAmt10;
	}

	public void setRentFeeAmt10(String rentFeeAmt10) {
		this.rentFeeAmt10 = rentFeeAmt10;
	}

	public String getRentFeeAmt11() {
		return rentFeeAmt11;
	}

	public void setRentFeeAmt11(String rentFeeAmt11) {
		this.rentFeeAmt11 = rentFeeAmt11;
	}

	public String getRentFeeAmt12() {
		return rentFeeAmt12;
	}

	public void setRentFeeAmt12(String rentFeeAmt12) {
		this.rentFeeAmt12 = rentFeeAmt12;
	}

	public String getRentFeeAmtQ1() {
		return rentFeeAmtQ1;
	}

	public void setRentFeeAmtQ1(String rentFeeAmtQ1) {
		this.rentFeeAmtQ1 = rentFeeAmtQ1;
	}

	public String getRentFeeAmtQ2() {
		return rentFeeAmtQ2;
	}

	public void setRentFeeAmtQ2(String rentFeeAmtQ2) {
		this.rentFeeAmtQ2 = rentFeeAmtQ2;
	}

	public String getRentFeeAmtQ3() {
		return rentFeeAmtQ3;
	}

	public void setRentFeeAmtQ3(String rentFeeAmtQ3) {
		this.rentFeeAmtQ3 = rentFeeAmtQ3;
	}

	public String getRentFeeAmtQ4() {
		return rentFeeAmtQ4;
	}

	public void setRentFeeAmtQ4(String rentFeeAmtQ4) {
		this.rentFeeAmtQ4 = rentFeeAmtQ4;
	}

	public String getRateOfExpense01() {
		return rateOfExpense01;
	}

	public void setRateOfExpense01(String rateOfExpense01) {
		this.rateOfExpense01 = rateOfExpense01;
	}

	public String getRateOfExpense02() {
		return rateOfExpense02;
	}

	public void setRateOfExpense02(String rateOfExpense02) {
		this.rateOfExpense02 = rateOfExpense02;
	}

	public String getRateOfExpense03() {
		return rateOfExpense03;
	}

	public void setRateOfExpense03(String rateOfExpense03) {
		this.rateOfExpense03 = rateOfExpense03;
	}

	public String getRateOfExpense04() {
		return rateOfExpense04;
	}

	public void setRateOfExpense04(String rateOfExpense04) {
		this.rateOfExpense04 = rateOfExpense04;
	}

	public String getRateOfExpense05() {
		return rateOfExpense05;
	}

	public void setRateOfExpense05(String rateOfExpense05) {
		this.rateOfExpense05 = rateOfExpense05;
	}

	public String getRateOfExpense06() {
		return rateOfExpense06;
	}

	public void setRateOfExpense06(String rateOfExpense06) {
		this.rateOfExpense06 = rateOfExpense06;
	}

	public String getRateOfExpense07() {
		return rateOfExpense07;
	}

	public void setRateOfExpense07(String rateOfExpense07) {
		this.rateOfExpense07 = rateOfExpense07;
	}

	public String getRateOfExpense08() {
		return rateOfExpense08;
	}

	public void setRateOfExpense08(String rateOfExpense08) {
		this.rateOfExpense08 = rateOfExpense08;
	}

	public String getRateOfExpense09() {
		return rateOfExpense09;
	}

	public void setRateOfExpense09(String rateOfExpense09) {
		this.rateOfExpense09 = rateOfExpense09;
	}

	public String getRateOfExpense10() {
		return rateOfExpense10;
	}

	public void setRateOfExpense10(String rateOfExpense10) {
		this.rateOfExpense10 = rateOfExpense10;
	}

	public String getRateOfExpense11() {
		return rateOfExpense11;
	}

	public void setRateOfExpense11(String rateOfExpense11) {
		this.rateOfExpense11 = rateOfExpense11;
	}

	public String getRateOfExpense12() {
		return rateOfExpense12;
	}

	public void setRateOfExpense12(String rateOfExpense12) {
		this.rateOfExpense12 = rateOfExpense12;
	}

	public String getRateOfExpenseQ1() {
		return rateOfExpenseQ1;
	}

	public void setRateOfExpenseQ1(String rateOfExpenseQ1) {
		this.rateOfExpenseQ1 = rateOfExpenseQ1;
	}

	public String getRateOfExpenseQ2() {
		return rateOfExpenseQ2;
	}

	public void setRateOfExpenseQ2(String rateOfExpenseQ2) {
		this.rateOfExpenseQ2 = rateOfExpenseQ2;
	}

	public String getRateOfExpenseQ3() {
		return rateOfExpenseQ3;
	}

	public void setRateOfExpenseQ3(String rateOfExpenseQ3) {
		this.rateOfExpenseQ3 = rateOfExpenseQ3;
	}

	public String getRateOfExpenseQ4() {
		return rateOfExpenseQ4;
	}

	public void setRateOfExpenseQ4(String rateOfExpenseQ4) {
		this.rateOfExpenseQ4 = rateOfExpenseQ4;
	}

	public String getRateOfReturn01() {
		return rateOfReturn01;
	}

	public void setRateOfReturn01(String rateOfReturn01) {
		this.rateOfReturn01 = rateOfReturn01;
	}

	public String getRateOfReturn02() {
		return rateOfReturn02;
	}

	public void setRateOfReturn02(String rateOfReturn02) {
		this.rateOfReturn02 = rateOfReturn02;
	}

	public String getRateOfReturn03() {
		return rateOfReturn03;
	}

	public void setRateOfReturn03(String rateOfReturn03) {
		this.rateOfReturn03 = rateOfReturn03;
	}

	public String getRateOfReturn04() {
		return rateOfReturn04;
	}

	public void setRateOfReturn04(String rateOfReturn04) {
		this.rateOfReturn04 = rateOfReturn04;
	}

	public String getRateOfReturn05() {
		return rateOfReturn05;
	}

	public void setRateOfReturn05(String rateOfReturn05) {
		this.rateOfReturn05 = rateOfReturn05;
	}

	public String getRateOfReturn06() {
		return rateOfReturn06;
	}

	public void setRateOfReturn06(String rateOfReturn06) {
		this.rateOfReturn06 = rateOfReturn06;
	}

	public String getRateOfReturn07() {
		return rateOfReturn07;
	}

	public void setRateOfReturn07(String rateOfReturn07) {
		this.rateOfReturn07 = rateOfReturn07;
	}

	public String getRateOfReturn08() {
		return rateOfReturn08;
	}

	public void setRateOfReturn08(String rateOfReturn08) {
		this.rateOfReturn08 = rateOfReturn08;
	}

	public String getRateOfReturn09() {
		return rateOfReturn09;
	}

	public void setRateOfReturn09(String rateOfReturn09) {
		this.rateOfReturn09 = rateOfReturn09;
	}

	public String getRateOfReturn10() {
		return rateOfReturn10;
	}

	public void setRateOfReturn10(String rateOfReturn10) {
		this.rateOfReturn10 = rateOfReturn10;
	}

	public String getRateOfReturn11() {
		return rateOfReturn11;
	}

	public void setRateOfReturn11(String rateOfReturn11) {
		this.rateOfReturn11 = rateOfReturn11;
	}

	public String getRateOfReturn12() {
		return rateOfReturn12;
	}

	public void setRateOfReturn12(String rateOfReturn12) {
		this.rateOfReturn12 = rateOfReturn12;
	}

	public String getRateOfReturnQ1() {
		return rateOfReturnQ1;
	}

	public void setRateOfReturnQ1(String rateOfReturnQ1) {
		this.rateOfReturnQ1 = rateOfReturnQ1;
	}

	public String getRateOfReturnQ2() {
		return rateOfReturnQ2;
	}

	public void setRateOfReturnQ2(String rateOfReturnQ2) {
		this.rateOfReturnQ2 = rateOfReturnQ2;
	}

	public String getRateOfReturnQ3() {
		return rateOfReturnQ3;
	}

	public void setRateOfReturnQ3(String rateOfReturnQ3) {
		this.rateOfReturnQ3 = rateOfReturnQ3;
	}

	public String getRateOfReturnQ4() {
		return rateOfReturnQ4;
	}

	public void setRateOfReturnQ4(String rateOfReturnQ4) {
		this.rateOfReturnQ4 = rateOfReturnQ4;
	}

	public String getCollectAmtTot() {
		return collectAmtTot;
	}

	public void setCollectAmtTot(String collectAmtTot) {
		this.collectAmtTot = collectAmtTot;
	}

	public String getRefundAmtTot() {
		return refundAmtTot;
	}

	public void setRefundAmtTot(String refundAmtTot) {
		this.refundAmtTot = refundAmtTot;
	}

	public String getRentFeeAmtTot() {
		return rentFeeAmtTot;
	}

	public void setRentFeeAmtTot(String rentFeeAmtTot) {
		this.rentFeeAmtTot = rentFeeAmtTot;
	}

	public String getRateOfExpenseTot() {
		return rateOfExpenseTot;
	}

	public void setRateOfExpenseTot(String rateOfExpenseTot) {
		this.rateOfExpenseTot = rateOfExpenseTot;
	}

	public String getRateOfReturnTot() {
		return rateOfReturnTot;
	}

	public void setRateOfReturnTot(String rateOfReturnTot) {
		this.rateOfReturnTot = rateOfReturnTot;
	}

	@Override
	public String toString() {
		return "MoneyCollectRptDto [rptKey=" + rptKey + ", boothDto=" + boothDto + ", boothGroupDto=" + boothGroupDto + ", collectAmt01=" + collectAmt01 + ", collectAmt02=" + collectAmt02
				+ ", collectAmt03=" + collectAmt03 + ", collectAmt04=" + collectAmt04 + ", collectAmt05=" + collectAmt05 + ", collectAmt06=" + collectAmt06 + ", collectAmt07=" + collectAmt07
				+ ", collectAmt08=" + collectAmt08 + ", collectAmt09=" + collectAmt09 + ", collectAmt10=" + collectAmt10 + ", collectAmt11=" + collectAmt11 + ", collectAmt12=" + collectAmt12
				+ ", collectAmtQ1=" + collectAmtQ1 + ", collectAmtQ2=" + collectAmtQ2 + ", collectAmtQ3=" + collectAmtQ3 + ", collectAmtQ4=" + collectAmtQ4 + ", refundAmt01=" + refundAmt01
				+ ", refundAmt02=" + refundAmt02 + ", refundAmt03=" + refundAmt03 + ", refundAmt04=" + refundAmt04 + ", refundAmt05=" + refundAmt05 + ", refundAmt06=" + refundAmt06 + ", refundAmt07="
				+ refundAmt07 + ", refundAmt08=" + refundAmt08 + ", refundAmt09=" + refundAmt09 + ", refundAmt10=" + refundAmt10 + ", refundAmt11=" + refundAmt11 + ", refundAmt12=" + refundAmt12
				+ ", refundAmtQ1=" + refundAmtQ1 + ", refundAmtQ2=" + refundAmtQ2 + ", refundAmtQ3=" + refundAmtQ3 + ", refundAmtQ4=" + refundAmtQ4 + ", rentFeeAmt01=" + rentFeeAmt01
				+ ", rentFeeAmt02=" + rentFeeAmt02 + ", rentFeeAmt03=" + rentFeeAmt03 + ", rentFeeAmt04=" + rentFeeAmt04 + ", rentFeeAmt05=" + rentFeeAmt05 + ", rentFeeAmt06=" + rentFeeAmt06
				+ ", rentFeeAmt07=" + rentFeeAmt07 + ", rentFeeAmt08=" + rentFeeAmt08 + ", rentFeeAmt09=" + rentFeeAmt09 + ", rentFeeAmt10=" + rentFeeAmt10 + ", rentFeeAmt11=" + rentFeeAmt11
				+ ", rentFeeAmt12=" + rentFeeAmt12 + ", rentFeeAmtQ1=" + rentFeeAmtQ1 + ", rentFeeAmtQ2=" + rentFeeAmtQ2 + ", rentFeeAmtQ3=" + rentFeeAmtQ3 + ", rentFeeAmtQ4=" + rentFeeAmtQ4
				+ ", rateOfExpense01=" + rateOfExpense01 + ", rateOfExpense02=" + rateOfExpense02 + ", rateOfExpense03=" + rateOfExpense03 + ", rateOfExpense04=" + rateOfExpense04
				+ ", rateOfExpense05=" + rateOfExpense05 + ", rateOfExpense06=" + rateOfExpense06 + ", rateOfExpense07=" + rateOfExpense07 + ", rateOfExpense08=" + rateOfExpense08
				+ ", rateOfExpense09=" + rateOfExpense09 + ", rateOfExpense10=" + rateOfExpense10 + ", rateOfExpense11=" + rateOfExpense11 + ", rateOfExpense12=" + rateOfExpense12
				+ ", rateOfExpenseQ1=" + rateOfExpenseQ1 + ", rateOfExpenseQ2=" + rateOfExpenseQ2 + ", rateOfExpenseQ3=" + rateOfExpenseQ3 + ", rateOfExpenseQ4=" + rateOfExpenseQ4
				+ ", rateOfReturn01=" + rateOfReturn01 + ", rateOfReturn02=" + rateOfReturn02 + ", rateOfReturn03=" + rateOfReturn03 + ", rateOfReturn04=" + rateOfReturn04 + ", rateOfReturn05="
				+ rateOfReturn05 + ", rateOfReturn06=" + rateOfReturn06 + ", rateOfReturn07=" + rateOfReturn07 + ", rateOfReturn08=" + rateOfReturn08 + ", rateOfReturn09=" + rateOfReturn09
				+ ", rateOfReturn10=" + rateOfReturn10 + ", rateOfReturn11=" + rateOfReturn11 + ", rateOfReturn12=" + rateOfReturn12 + ", rateOfReturnQ1=" + rateOfReturnQ1 + ", rateOfReturnQ2="
				+ rateOfReturnQ2 + ", rateOfReturnQ3=" + rateOfReturnQ3 + ", rateOfReturnQ4=" + rateOfReturnQ4 + ", collectAmtTot=" + collectAmtTot + ", refundAmtTot=" + refundAmtTot
				+ ", rentFeeAmtTot=" + rentFeeAmtTot + ", rateOfExpenseTot=" + rateOfExpenseTot + ", rateOfReturnTot=" + rateOfReturnTot + "]";
	}

}
