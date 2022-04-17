/* global Task */

(function setup(Task) {
  const tasks = {};

  // eslint-disable-next-line no-param-reassign
  Task.run = (path, args, callback) => {
    const task = new Task(path, args, (handler) => {
      if (callback) {
        callback(handler);
      }

      Task.terminate(handler.id);
    });

    if (task) {
      tasks[task.id] = task;
      return task.id;
    }

    return null;
  };

  // eslint-disable-next-line no-param-reassign
  Task.terminate = (identifier) => {
    const task = tasks[identifier];

    if (task) {
      task.terminate();
      delete tasks[identifier];
    }
  };
}(Task));
