using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Administration;
using Microsoft.SharePoint.WebControls;

namespace Nauplius.SharePoint.CrawlTarget.Layouts.Nauplius.SharePoint.CrawlTarget
{
    public partial class Target : LayoutsPageBase
    {
        private SPWebApplication webApplication;
        private readonly string _webFoundation = @"Microsoft SharePoint Foundation Web Application";
        protected void Page_Init(object sender, EventArgs e)
        {
            var farm = SPFarm.Local;
            var webAppId = new Guid(Request["Id"]);
            webApplication = (SPWebApplication)farm.GetObject(webAppId);

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            CreateDataTable();
        }

        private void CreateDataTable()
        {
            var dt = new DataTable();
            dt.Columns.Add("Web Application", typeof (SPWebApplication));
            dt.Columns.Add("Zone", typeof (SPUrlZone));
            dt.Columns.Add("Crawl Target", typeof (SPServer));

        }

        private void AddMapping(SPWebApplication webApp, SPUrlZone zone, SPServer server)
        {
            if (webApp == null || server == null) return;
            var uri = new Uri("http://" + server.Name);
            var list = new List<System.Uri>(1) {uri};
            webApp.SiteDataServers.Add(zone, list);
            webApp.Update();
        }

        private void RemoveMapping(SPWebApplication webApp, SPUrlZone zone, SPServer server)
        {
            if (webApp == null || server == null) return;
            webApp.SiteDataServers.Remove(zone);
            webApp.Update();
        }

        private void HttpThrottle(SPServer server, bool remove)
        {
            var webService = SPFarm.Local.Services.OfType<SPWebService>().First();
            var instance = new SPWebServiceInstance(_webFoundation, server, webService) { DisableLocalHttpThrottling = remove };
            instance.Update();
        }

        protected void btnCancel_OnCancel(object sender, EventArgs e)
        {

        }

        protected void btnSave_OnSave(object sender, EventArgs e)
        {
            
        }
    }
}
