<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTarget.aspx.cs" Inherits="Nauplius.SharePoint.CrawlTarget.Layouts.Nauplius.SharePoint.CrawlTarget.AddTarget" DynamicMasterPageFile="~masterurl/default.master" %>

<%@ Register TagPrefix="wssuc" TagName="InputFormSection" src="~/_controltemplates/InputFormSection.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="InputFormControl" src="~/_controltemplates/InputFormControl.ascx" %>
<%@ Register TagPrefix="wssuc" TagName="ButtonSection" src="~/_controltemplates/ButtonSection.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <table border="0" cellspacing="0" cellpadding="0" class="ms-propertysheet" width="100%">
        <colgroup>
            <col style="width: 40%" />
            <col style="width: 60%" />
        </colgroup>
	    <tr>
		    <td>
			    <wssuc:InputFormSection ID="InputFormSection1" runat="server" 
                    Title="Zone" 
                    Description="The crawl target will apply to requests made for the specified zone.">
				    <template_inputformcontrols>
					    <wssuc:InputFormControl runat="server">
						    <Template_Control>                   
							    <div class="ms-authoringcontrols">
                                    <asp:DropDownList runat="server" ID="ddlZones"/>            
							    </div>
						    </Template_Control>
					    </wssuc:InputFormControl>
				    </template_inputformcontrols>
			    </wssuc:InputFormSection>
		    </td>
	    </tr>
        <tr>
            <td>
                <wssuc:InputFormSection ID="InputFormSection2" runat="server"
                    Title="Crawl Target"
                    Description="The server that will be the crawl target for search.">
                    <template_inputformcontrols>
                        <wssuc:InputFormControl runat="server">
                            <Template_Control>
                                <asp:DropDownList runat="server" ID="ddlHosts" OnSelectedIndexChanged="ddlHosts_OnSelectedIndexChange"/>
                            </Template_Control>
                        </wssuc:InputFormControl>
                    </template_inputformcontrols>
                </wssuc:InputFormSection>
            </td>
        </tr>
        <tr>
            <td>
                <wssuc:InputFormSection ID="InputFormSection3" runat="server"
                    Title="HTTP Throttle Control"
                    Description="Disabling HTTP throttling prevents crawl requests from being queued and delayed. Only disable HTTP throttling on a server dedicated for crawling.">
                    <template_inputformcontrols>
                        <wssuc:InputFormControl runat="server">
                            <Template_Control>
                                <asp:CheckBox runat="server" ID="chkThrottle" Text="Disable Throttle" />
                            </Template_Control>
                        </wssuc:InputFormControl>
                    </template_inputformcontrols>
                </wssuc:InputFormSection>
            </td>
        </tr>
        <wssuc:ButtonSection runat="server" TopButtons="true" BottomSpacing="5" ShowSectionLine="false" ShowStandardCancelButton="false">
		    <Template_Buttons>
			    <asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="btnOk_OnClick" 
                    Text="Save" id="btnSaveTop"/>
			    <asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="btnCancel_OnClick" 
                    Text="<%$Resources:wss,multipages_cancelbutton_text%>" id="btnCancelTop" accesskey="<%$Resources:wss,cancelbutton_accesskey%>" CausesValidation="false"/>
		    </Template_Buttons>
	    </wssuc:ButtonSection>  
    </table>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Add Crawl Target
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
