require "etc"

class MBankAccountProtectionProxy
  def initialize(subject, owner)
    @subject = subject
    @owner = owner
  end

  def check_access
    if Etc.getlogin != @owner
      raise "Illegal access: #{Etc.getlogin} cannot access account."
    end
  end

  def method_missing(name, *args)
    check_access
    @subject.send(name, *args)
  end
end
