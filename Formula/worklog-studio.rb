class WorklogStudio < Formula
  desc "Local Jira worklog and Mac Calendar review app"
  homepage "https://github.com/imfeemily/worklog-studio"
  url "https://github.com/imfeemily/worklog-studio/releases/download/v0.1.1/worklog-studio-0.1.1.tar.gz"
  version "0.1.1"
  sha256 "d54f02ac094a45db22ffce0352a87c3f6720fc548fa7a0f5e87697d7eeecdcba"

  depends_on :macos
  depends_on "python@3.14"

  def install
    libexec.install "app.py", "calendar_worklogs.py", "index.html", "app.js", "calendar.js",
                    "styles.css", "mac_calendar.swift", "mac_calendar-Info.plist"
    launcher = bin/"worklog-studio"
    launcher.write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("python@3.14")}/python3.14" "#{libexec}/app.py" "$@"
    SH
    launcher.chmod 0755
  end

  test do
    assert_match "Worklog Studio #{version}", shell_output("#{bin}/worklog-studio --version")
  end
end
