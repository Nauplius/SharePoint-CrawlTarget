<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Target.aspx.cs" Inherits="Nauplius.SharePoint.CrawlTarget.Layouts.Nauplius.SharePoint.CrawlTarget.Target" DynamicMasterPageFile="~masterurl/default.master" %>

<%@ Register TagPrefix="wssuc" TagName="ButtonSection" src="~/_controltemplates/ButtonSection.ascx" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">

</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
        	<wssuc:ButtonSection runat="server" TopButtons="true" BottomSpacing="5" ShowSectionLine="false" ShowStandardCancelButton="false">
		<Template_Buttons>
			<asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="btnSave_OnSave" 
                Text="Save" id="btnSaveTop"/>
			<asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="btnCancel" 
                Text="<%$Resources:wss,multipages_cancelbutton_text%>" id="btnCancelTop" accesskey="<%$Resources:wss,cancelbutton_accesskey%>" CausesValidation="false"/>
		</Template_Buttons>
	</wssuc:ButtonSection>

    <SharePoint:SPGridView ID="gvCT" runat="server" AutoGenerateColumns="False" Enabled="True">
    </SharePoint:SPGridView>
    
    	<wssuc:ButtonSection runat="server" TopButtons="true" BottomSpacing="5" ShowSectionLine="false" ShowStandardCancelButton="false">
		<Template_Buttons>
			<asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="btnSave_OnSave" 
                Text="Save" id="btnSaveBottom"/>
			<asp:Button UseSubmitBehavior="false" runat="server" class="ms-ButtonHeightWidth" OnClick="btnCancel_OnCancel" 
                Text="<%$Resources:wss,multipages_cancelbutton_text%>" id="btnCancelBottom" accesskey="<%$Resources:wss,cancelbutton_accesskey%>" CausesValidation="false"/>
		</Template_Buttons>
	</wssuc:ButtonSection>
</asp:Content>

<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
Application Page
</asp:Content>

<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server" >
My Application Page
</asp:Content>
