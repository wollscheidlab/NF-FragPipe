process fragpipeSearch {
    tag "$manifest_fp"
    publishDir 'Results/FragPipe', mode: 'copy'
    cpus params.fragpipe_threads

    input:
    val tools_folder_fp
    val diann_fp
    val python_fp
    path workflow_fp
    path manifest_fp
    path raw_data
    path database_fp
    val fragpipe_threads

    output:
    path '*'
    path 'manifest.fp-manifest'

    script:
    // Replace Database path in FragPipe workflow file with user selected one.
    // Run FragPipe analysis in headless mode
    """
    sed -i 's|database.db-path=.*|database.db-path=${database_fp}|' ${workflow_fp}
    fragpipe --headless --config-tools-folder ${tools_folder_fp} --config-diann ${diann_fp} --config-python ${python_fp} --threads $fragpipe_threads --workflow  ${workflow_fp} --manifest ${manifest_fp} --workdir .
    """
}
