process fragpipeSearch {
    tag "$manifest_fp"
    publishDir 'Results/FragPipe', mode: 'copy'
    cpus params.fragpipe_threads

    input:
    path workflow_fp
    path manifest_fp
    path raw_data
    path database_fp
    val fragpipe_threads

    output:
    path 'combined_ion.tsv'
    path 'combined_modified_peptide.tsv'
    path 'combined_peptide.tsv'
    path 'combined_protein.tsv'
    path 'combined.prot.xml'
    path 'experiment_annotation.tsv'
    path 'sdrf.tsv'
    path 'reprint.int.tsv'
    path 'reprint.spc.tsv'
    path 'MSstats.csv'
    path 'log*.txt'
    path 'manifest.fp-manifest'
    path 'fragpipe.workflow'

    script:
    // Replace Database path in FragPipe workflow file with user selected one.
    // Run FragPipe analysis in headless mode
    """
    sed -i 's|database.db-path=.*|database.db-path=${database_fp}|' ${workflow_fp}
    fragpipe --headless --threads $fragpipe_threads --workflow  ${workflow_fp} --manifest ${manifest_fp} --workdir .
    """
}
