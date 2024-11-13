# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* [Qihan Guan] 
* *email:* [qgguan@ucdavis.edu]

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The controller/screen draws a 5 by 5 unit cross in the center of the screen when draw_camera_logic is true.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
 Every requirement is fulfilled. The controller draws a frame border box when draw_camera_logic is true. 
 And if the player is touching the left edge box, the player would get pushed forward by the box edge. And exported the required variables.

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera trails behind the players based on the follow_speed, and it also works during hyperspeed. 
Exported variables like catchup_speed and leash_distance work as described based on my testing. The only problem I notice is that the movement is jittery, but that isn't listed as a requirement for Stage 3. And more to do with the Vessell script from what i have heard.

___
### Stage 4 ###

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera leads the player in the direction of the player input. But it doesn't work during hyperspeed.
And the student exported all of the required variables and they're all working as intended from my testing. However, the problem with the player's jittery movement persists from stage 3.
___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [x] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The player can push the box in the direction they're moving, at both normal and hyper-speed when it touches the edges and corners. But the push_ratio is not implemented, so it's not accounted for in the movement calculation. 

https://github.com/ensemble-ai/exercise-2-camera-control-normanmgu/blob/a16b9633fcff8e869393dfc3037ab8f0d120f4b0/Obscura/scripts/camera_controllers/push_box.gd#L14-L42

Another problem is the Speed-up Zone and the Push Zone are not distinguished. In the Push Zone(not touching the corners), the camera doesn't follow the player and simply acts the same as the Speed-up Zone. The student also didn't export any of the required variables.

I mark this as "good" because there are 2 major flaws, a lack of zone distinction and push_ratio not being implemented. And some minor flaws like no exported variables. 

___
# Code Style #

The code adheres to the style guide of this class. It's well-structured,  easy to read, and no obsolete codes.


#### Style Guide Infractions ####

None.

#### Style Guide Exemplars ####

There are many descriptive and helpful comments for the code. For example, it's full of them for the Stage 3 script
https://github.com/ensemble-ai/exercise-2-camera-control-normanmgu/blob/a16b9633fcff8e869393dfc3037ab8f0d120f4b0/Obscura/scripts/lerp_smoothing_camera.gd#L15-L42

# Best Practices #

The code adheres to the best practices and the coding convention of GDScript. I don't see any Infractions other than a very minor indentation mistake.


#### Best Practices Infractions ####

One minor indentaion mistake for a comment.
https://github.com/ensemble-ai/exercise-2-camera-control-normanmgu/blob/a16b9633fcff8e869393dfc3037ab8f0d120f4b0/Obscura/scripts/lerp_target_smoothing_camera.gd#L35-L36

#### Best Practices Exemplars ####

The code is very well-structured, it make it self-explanatory even without the comments.
https://github.com/ensemble-ai/exercise-2-camera-control-normanmgu/blob/a16b9633fcff8e869393dfc3037ab8f0d120f4b0/Obscura/scripts/lerp_target_smoothing_camera.gd#L21-L54

