~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"aR=0eZ3`te%wPO}=Nb;kChod)pjQRalbbcXy_?zw3hQoVEq?`t[br62EU&IHQJ;Z"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"_3V?!TE.JFh3<UA|ND>8`&oTs)~wP}g;DP&Eu[.wlYjUPtvUb53TNl.9x_xsRG3L"
  set vm_args: "rel/vm.args"
end

release :resuelvef do
  set version: current_version(:resuelvef)
  set applications: [
    :runtime_tools
  ]
end
