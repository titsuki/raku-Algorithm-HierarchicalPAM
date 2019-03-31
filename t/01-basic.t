use v6.c;
use Test;
use Algorithm::HierarchicalPAM;
use Algorithm::HierarchicalPAM::HierarchicalPAMModel;
use Algorithm::HierarchicalPAM::Document;
use Algorithm::HierarchicalPAM::Formatter;

subtest {
    my @documents = (
        "a b c",
        "d e f",
    );
    my ($documents, $vocabs) = Algorithm::HierarchicalPAM::Formatter.from-plain(@documents);
    is-deeply $vocabs, ["a", "b", "c", "d", "e", "f"];
    my Algorithm::HierarchicalPAM $hpam .= new(:$documents, :$vocabs);
    my Algorithm::HierarchicalPAM::HierarchicalPAMModel $model = $hpam.fit(:num-super-topics(3), :num-sub-topics(5), :num-iterations(1000));
    lives-ok { $model.topic-word-matrix }
    lives-ok { $model.document-topic-matrix }
    lives-ok { $model.log-likelihood }
    lives-ok { $model.nbest-words-per-topic }
}, "Check if it could process a very short document. (just a smoke test)";

done-testing;
