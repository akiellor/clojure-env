dep 'file' do
  met? { "~/test".p.file? }
  meet { shell "touch ~/test" }
end
