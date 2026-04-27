import React from 'react';
import { motion } from 'framer-motion';
import { FaBriefcase, FaGraduationCap } from 'react-icons/fa';

const EXPERIENCES = [
  { title:'Web Development Intern', company:'PS CODERS', date:'Jul 2024 – Oct 2024', type:'work',
    bullets:['Engineered dynamic and responsive front-end interfaces using modern web technologies.','Collaborated with cross-functional teams to optimise UI/UX and improve overall application performance.','Ensured cross-browser compatibility and adhered to clean code architecture and standard development workflows.'] },
  { title:'Cloud Computing Fellow', company:'ACM UET Lahore', date:'Jun 2024 – Aug 2024', type:'work',
    bullets:['Gained hands-on experience in cloud infrastructure, DevOps practices, and server management.','Deployed scalable web applications leveraging AWS services, including Elastic Beanstalk and EC2.','Implemented containerised environments using Docker, focusing on port mapping, volume mounting, and multi-container NGINX architectures.'] },
  { title:'BS Software Engineering', company:'University of Sindh', date:'Jan 2022 – Dec 2025', type:'education',
    bullets:['Mastered core computer science principles including Data Structures, OOP, and full-stack methodologies.',"Developed 'Gadd Kaam – SkillSwap Pakistan' as Final Year Project: a secure MERN-stack platform for cashless skill trading.",'Earned multiple certifications in .NET, React.js, Docker, and Cloud Fundamentals throughout the degree.'] },
];

const Experience = () => (
  <section className="experience" id="experience">
    <motion.h2 initial={{ opacity:0, y:-20 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:true }}>
      Experience &amp; Education
    </motion.h2>
    <div className="timeline">
      {EXPERIENCES.map((exp, i) => (
        <motion.div className="timeline-item" key={i}
          initial={{ opacity:0, x:-50 }} whileInView={{ opacity:1, x:0 }}
          viewport={{ once:true, margin:'-60px' }} transition={{ duration:.5, delay:i*.15 }}>
          <div className={`timeline-icon timeline-icon--${exp.type}`}>
            {exp.type==='work' ? <FaBriefcase /> : <FaGraduationCap />}
          </div>
          <div className="timeline-content">
            <span className="timeline-date">{exp.date}</span>
            <h3>{exp.title}</h3>
            <h4 className="highlight">{exp.company}</h4>
            <ul className="timeline-bullets">
              {exp.bullets.map((b, bi) => <li key={bi}>{b}</li>)}
            </ul>
          </div>
        </motion.div>
      ))}
    </div>
  </section>
);
export default Experience;