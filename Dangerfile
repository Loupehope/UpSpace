
# Warn when there is a big PR
warn('This PR is too big! Consider breaking it down into smaller PRs.') if git.lines_of_code > 600

# Checks for changelog entry
unless git.modified_files.include?("CHANGELOG.md")
  fail("Please include a CHANGELOG entry. \nYou can find it at [CHANGELOG.md](https://github.com/TouchInstinct/LeadKit/blob/master/CHANGELOG.md).", sticky: false)
end

# Make sure that version has been bumped in podspecs
all_podspec_files = Dir.entries(".").grep(/.podspec$/)
modified_podspec_files = git.modified_files.grep(/.podspec$/)
missed_podspecs = all_podspec_files - modified_podspec_files

unless missed_podspecs.empty?
  fail("Please update version in missed podspecs: " + missed_podspecs.join(", "), sticky: false)
end