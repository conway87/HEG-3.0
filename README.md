
## About

HEG is designed to act as a log generation tool for logging verification, logging validation, detection validation etc

As an event generator, as opposed to an attack simulator, you may notice HEG execute the same step repeatedly but using a different technique. It may also execute numerous steps that achieve overlapping outcomes, which would be unnecessary if performed by an actual attacker. This is specifically so a defender can see how various tracks to the same outcome might look like.

The generated logs are output to a csv file after completion to allow for easier analysis. To see a sample - **[click here](#)**


### Usage
Although HEG is not designed as an attack simulation tool (and caution has been taken to defang it where possible), it is still recommended to use HEG only on non-critical infrastructure. Careful consideration should be given before deploying HEG on any production systems.


<br>


## Getting Started
1. To get the most out of HEG read the wiki… **[here](#)**
&nbsp;

3. For quick start, with minimal fuss:
   
    * Download and extract repo
    * Launch PowerShell as admin
    * Locate and run `HEG.ps1`
    * After it completes, check the Logs directory


<br>

## Companion Tools

HEG - BeefEater: This edition of HEG doesnt look pretty, but it generates a ton more events than standard HEG. BeefEater edition is more suited to people in the detection field. If you want ALL the logs - this is the one.

HEG - PA: System assessment to determine what current logging levels look like. See which EventIds are logging, which ones arent.

HEG - AA: Runs an automated analaysis on the logs generated from HEG. Highlights and annotates the various IOCs HEG generated that should be picked up by SOC.
