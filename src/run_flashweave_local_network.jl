using FlashWeave
sixteenS = ARGS[1]
eighteenS = ARGS[2]
metafile = ARGS[3]
outfile = ARGS[4]
data_path = [sixteenS, eighteenS]
netw_results = learn_network(data_path, sensitive=true, heterogeneous=false)
G = graph(netw_results)
save_network(outfile, netw_results)