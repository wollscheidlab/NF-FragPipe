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
    path '*'

    script:
    // Replace Database path in FragPipe workflow file with user selected one.
    // Run FragPipe analysis in headless mode
    """
    sed -i 's|database.db-path=.*|database.db-path=${database_fp}|' ${workflow_fp}
    fragpipe --headless --threads $fragpipe_threads --workflow  ${workflow_fp} --manifest ${manifest_fp} --workdir .
    """
}
