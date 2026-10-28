class WorklogStudio < Formula
  desc "Local Jira worklog and Mac Calendar review app"
  homepage "https://github.com/imfeemily/worklog-studio"
  url "https://github.com/imfeemily/worklog-studio/releases/download/v0.1.0/worklog-studio-0.1.0.tar.gz"
  version "0.1.0"
  sha256 "ef64a384a8790d6dcf4fbc3a1c809a15f4de3ee85a643d7af144bb263f862aab"

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
