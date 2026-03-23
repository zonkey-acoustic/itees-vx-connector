namespace VxProxy;

static class Program
{
    [STAThread]
    static void Main()
    {
        ApplicationConfiguration.Initialize();

        if (IsInfiniteTeesOnPort921())
        {
            MessageBox.Show(
                "Infinite Tees is already configured to listen on port 921.\n\n" +
                "ProTee Labs will connect directly to Infinite Tees — the proxy is not needed.",
                "VX Connector",
                MessageBoxButtons.OK,
                MessageBoxIcon.Information);
            return;
        }

        Application.Run(new TrayApplicationContext());
    }

    private static bool IsInfiniteTeesOnPort921()
    {
        var iniPath = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            "InfiniteTees", "Saved", "Config", "Windows", "GameUserSettings.ini");

        if (!File.Exists(iniPath))
            return false;

        var content = File.ReadAllText(iniPath);
        return content.Contains("Port=921");
    }
}
