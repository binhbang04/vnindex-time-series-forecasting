rename ThayđổicủaVNIndexsovớingàyhômtrư VNINDEX
rename ThayđổicủaTỷgiásovớingàyhômtrước USD_VND
rename LãisuấtFED FED
rename Thayđổicủagiávàngsovớihômtrước AUD
rename Thayđổicủagiádầusovớihômtrước WTI

destring VNINDEX, ignore("%,") replace
destring USD_VND, ignore("%,") replace
destring FED, ignore("%,") replace
destring AUD, ignore("%,") replace
destring WTI, ignore("%,") replace

twoway line VNINDEX TIME
generate TIME1 = _n

describe
summarize