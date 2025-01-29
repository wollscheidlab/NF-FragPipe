nextflow.enable.dsl=2

include {search} from './fragpipe_workflows.nf'

workflow {
    main:
    log.info("++++++++++========================================")
    log.info("Executing FragPipe workflow")
    log.info("")
    log.info("Parameters:")
    log.info(" Workflow:\t $params.workflow_fp")
    log.info(" Manifest:\t $params.manifest_fp")
    log.info(" Database:\t $params.database_fp")
    log.info("++++++++++========================================")

    // Extract the list of files we need to search from FragPipe manifest file
    Channel.fromPath(params.manifest_fp)
	.splitCsv(sep: '\t')
	.map { row -> file("${row[0]}") }
	.set { file_list }

    file_list.toList()
	.set { raw_files }
        
    // Run FragPipe analysis
    search(file(params.workflow_fp),
	   file(params.manifest_fp),
	   raw_files,
	   file(params.database_fp),
	   params.fragpipe_threads)
}
