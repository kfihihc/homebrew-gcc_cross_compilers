require 'formula'

class I586ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  sha1 'b4ee6e9bdebc65223f95067d0cc1a634b59dad72'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i586-elf-binutils'

  def install
    binutils = Formula.factory 'i586-elf-binutils'

    ENV['CC'] = '/usr/bin/gcc'
    ENV['CXX'] = '/usr/bin/g++'
    ENV['CPP'] = '/usr/bin/cpp'
    ENV['LD'] = '/usr/bin/gcc'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i586-elf',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i586-elf", prefix/"i586-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
