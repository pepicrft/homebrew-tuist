class TuistAT3211 < Formula
  desc "Create, maintain, and interact with Xcode projects at scale"
  homepage "https://tuist.io"
  url "https://github.com/tuist/tuist/archive/refs/tags/4.40.0.tar.gz"
  sha256 "9c948de7d51cf7cd53494f9db84000a6e12396dc0b8629e896eede8cf409d780"
  license "MIT"
  head "https://github.com/tuist/tuist.git", branch: "main"

  # https://github.com/tuist/tuist/blob/3.21.1/.xcode-version#L1
  depends_on xcode: ["14.3", :build]

  # https://github.com/tuist/tuist/blob/3.21.1/Package.swift#L14
  depends_on macos: :monterey

  def install
    # https://github.com/tuist/tuist/blob/3.21.1/.github/workflows/tuist.yml#L81
    system "swift", "build",
      "--configuration", "release",
      "--product", "tuist",
      "--disable-sandbox"

    # https://github.com/tuist/tuist/blob/3.21.1/.github/workflows/tuist.yml#L85
    system "swift", "build",
      "--configuration", "release",
      "--product", "ProjectDescription",
      "--disable-sandbox"

    # https://github.com/tuist/tuist/blob/3.21.1/Sources/TuistEnvKit/Installer/BuildCopier.swift#L13
    bin.install ".build/release/tuist"
    bin.install "Templates"
    bin.install "projects/tuist/vendor"
    bin.install ".build/release/ProjectDescription.swiftmodule"
    bin.install ".build/release/ProjectDescription.swiftdoc"
    bin.install ".build/release/libProjectDescription.dylib"
  end
end
