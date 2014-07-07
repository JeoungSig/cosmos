<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="sysProp" value="<%=com.cosmos.framework.CosmosContext.SYSTEM_PROPERTY%>" />
<c:set var="license" value="<%=com.cosmos.framework.CosmosContext.LICENSE%>" />

<table style="width: 100%;">
    <tr style="height: 5px">
        <td style="background-color: #a8d3ff"></td>
    </tr>
    <tr>
        <td style="background-color: #EAEAEA">
            <table style="width: 100%;">
                <tr>
                    <td align="right">
                        <div style="font-size: 12px; color: #8d8d8d">
                            <c:out value="${sysProp.copyright }" escapeXml="false" />
                            <c:if test="${license.licenseType == 'EVALUATION'  }">
                               <b><font color="#B70000">
                                 This system is evaluation version. It will be expired on 
                                <c:out value="${fn:substring(license.expireDate, 6,8)}"/>/<c:out value="${fn:substring(license.expireDate, 4,6)}"/>/<c:out value="${fn:substring(license.expireDate, 0,4)}"/></font>
                                </b>
                            </c:if>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
