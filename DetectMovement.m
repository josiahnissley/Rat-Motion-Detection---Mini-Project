function movement = DetectMovement(vel, high_thresh, low_thresh)
% detect_movement detects movement using double thresholding
%   movment = detect_movement(vel, high_thresh, low_thresh)
%   vel = 1D array of velocity values over time
%   high_thresh - upper threshold (definite movement)
%   low_thresh - lower threshold (possible movement)
% Output: 
%   movement - logical array of same size as vel (true where movement
%   detected)

    movement = false(size(vel));     % initialize movement array
    last_labeled_index = 0;           % to skip already labeled movement regions

    for i = 1:length(vel)
        if i <= last_labeled_index
            continue % skip if already labeled
        end

        if vel(i) > high_thresh
            left = i;
            right = i;

            % Expand to the left
            while left > 1 && vel(left - 1) > low_thresh
                left = left - 1;
            end

            % Expand to the right
            while right < length(vel) && vel(right + 1) > low_thresh
                right = right + 1;
            end

            % Mark movement region
            movement(left:right) = true;

            % Update last labeled index
            last_labeled_index = right;
        end
    end
end

