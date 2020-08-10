class Freepass < Formula
  desc "Free password manager for power users - CLI"
  homepage "https://github.com/myfreeweb/freepass"

  stable do
    # submodules are cloned automatically
    url "https://github.com/myfreeweb/freepass.git",
      :revision => "7861153baae6f557faacecbda5412b307ca220b8"
    version "0.0.0"
  end

  head do
    url "https://github.com/myfreeweb/freepass.git"
  end

  depends_on "rust" => :build
  depends_on "libsodium"
  depends_on "llvm"

  def install
    mkdir("cli") do
      system "cargo", "install", "--locked", "--root", prefix, "--path", "."
    end
  end

  test do
    system "#{bin}/freepass", "--version"
  end
end
