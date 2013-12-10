using System.Globalization;
using System.Web;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.Utilities;
using Microsoft.SharePoint.WebControls;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Nauplius.SharePoint.CrawlTarget.Layouts.Nauplius.SharePoint.CrawlTarget
{
    public partial class NewCrawlTarget : LayoutsPageBase
    {
        private SPWebApplication _webApplication;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            Web.AllowUnsafeUpdates = true;
            try
            {
                _webApplication = SPWebApplication.Lookup(new Uri(Request.QueryString["WA"]));
            }
            catch (SPException exception)
            {
                SPUtility.TransferToErrorPage("An error occurred attempting to resolve the Web Application ID, please contact your Administrator.");
            }

            var serverCollection = FoundationWebServers();
            ddlHosts.DataSource = serverCollection;
            ddlHosts.DataTextField = "Address";
            ddlHosts.DataBind();

            var zoneHash = GetEnumForBind(typeof(SPUrlZone));
            ddlZones.DataSource = zoneHash;
            ddlZones.DataTextField = "value";
            ddlZones.DataBind();

            foreach (var server in SPFarm.Local.Servers.Where(server => server.DisplayName == ddlHosts.SelectedValue))
            {
                chkThrottle.Checked = Mapping.EnumHttpThrottle(server);
            }

            Web.AllowUnsafeUpdates = false;
        }

        public Hashtable GetEnumForBind(Type enumeration)
        {
            var names = Enum.GetNames(enumeration);
            var values = Enum.GetValues(enumeration);
            var ht = new Hashtable();
            for (var i = 0; i < names.Length; i++)
            {
                ht.Add(Convert.ToInt32(values.GetValue(i)).ToString(CultureInfo.InvariantCulture), names[i]);
            }
            return ht;
        }

        protected void btnSave_OnClick(object sender, EventArgs e)
        {
            try
            {
                _webApplication = SPWebApplication.Lookup(new Uri(Request.QueryString["WA"]));
            }
            catch (SPException exception)
            {
                SPUtility.TransferToErrorPage("An error occurred attempting to resolve the Web Application ID, please contact your Administrator.");
            }

            SPUrlZone zone;
            Enum.TryParse(ddlZones.SelectedValue, out zone);

            foreach (var server in SPFarm.Local.Servers.Where(server => server.DisplayName == ddlHosts.SelectedValue))
            {
                Mapping.AddMapping(_webApplication, zone, server);

                if (chkThrottle.Checked)
                {
                    Mapping.HttpThrottle(server, true);
                }
                else if (!chkThrottle.Checked)
                {
                    Mapping.HttpThrottle(server, false);
                }
                break;
            }

            var context = HttpContext.Current;
            if (HttpContext.Current.Request.QueryString["IsDlg"] == null) return;
            context.Response.Write("<script type='text/javascript'>window.frameElement.commitPopup();</script>");
            context.Response.Flush();
            context.Response.End();
        }

        protected void btnCancel_OnClick(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            if (HttpContext.Current.Request.QueryString["IsDlg"] == null) return;
            context.Response.Write("<script type='text/javascript'>window.frameElement.commitPopup();</script>");
            context.Response.Flush();
            context.Response.End();
        }

        protected void ddlHosts_OnSelectedIndexChange(object sender, EventArgs e)
        {
            foreach (var server in SPFarm.Local.Servers.Where(server => server.DisplayName == ddlHosts.SelectedValue))
            {
               chkThrottle.Checked = Mapping.EnumHttpThrottle(server);
            }
        }

        private List<SPServer> FoundationWebServers()
        {
            return (from server in SPFarm.Local.Servers where server.Role != SPServerRole.Invalid from service in server.ServiceInstances 
                    where service.Status == SPObjectStatus.Online && 
                    service.TypeName == @"Microsoft SharePoint Foundation Web Application" 
                    select server).ToList();
        }
    }
}
