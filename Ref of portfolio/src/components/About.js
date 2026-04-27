import React from 'react';
import { motion } from 'framer-motion';
import { FaCode, FaLaptopCode, FaCloudUploadAlt, FaUserCheck } from 'react-icons/fa';
import cvFile from '../assets/Farmanullah Ansari CV - All.pdf';

const HIGHLIGHTS = [
  { icon:<FaCode />,           title:'Clean Code',   desc:'Readable, maintainable, and well-structured code is a priority in every project.',                      color:'#e040fb' },
  { icon:<FaLaptopCode />,     title:'Modern Stack', desc:'Proficient in MERN, ASP.NET Core, and cloud-native technologies for full-stack delivery.',               color:'#00e5ff' },
  { icon:<FaCloudUploadAlt />, title:'Cloud-Ready',  desc:'Experienced deploying scalable apps on AWS with Docker, CI/CD pipelines, and DevOps practices.',         color:'#00e676' },
  { icon:<FaUserCheck />,      title:'User-Focused', desc:'Every design decision stems from empathy for users — fast, accessible, and intuitive interfaces.',       color:'#ffab40' },
];

const About = () => (
  <motion.section
    className="about" id="about"
    initial={{ opacity:0, y:50 }}
    whileInView={{ opacity:1, y:0 }}
    viewport={{ once:true, margin:'-80px' }}
    transition={{ duration:.6 }}
  >
    <h2>About Me</h2>
    <div className="about-body">
      <motion.div className="about-text"
        initial={{ opacity:0, x:-30 }} whileInView={{ opacity:1, x:0 }} viewport={{ once:true }}
        transition={{ delay:.15, duration:.6 }}>
        <p>
          I'm a passionate <span className="highlight">Full-Stack Software Engineer</span> based in Pakistan,
          specialising in building exceptional digital experiences. With a strong foundation in modern
          frameworks and scalable architectures, I transform complex problems into elegant, performant solutions.
        </p>
        <p>
          When I'm not coding, I'm exploring new cloud technologies, contributing to open-source projects,
          or writing technical articles to share knowledge with the community.
        </p>
        <div className="about-buttons">
          <a href={cvFile} download="Farmanullah_Ansari_CV.pdf" className="btn-primary">Download My CV</a>
          <a href="#contact" className="btn-secondary">Hire Me</a>
        </div>
      </motion.div>

      <div className="about-highlights">
        {HIGHLIGHTS.map((h, i) => (
          <motion.div
            className="about-card" key={i}
            initial={{ opacity:0, y:24 }} whileInView={{ opacity:1, y:0 }}
            viewport={{ once:true }} transition={{ delay:.1+i*.1, duration:.5 }}
            whileHover={{ y:-7 }}
          >
            <div className="about-card-icon" style={{ '--ac': h.color }}>{h.icon}</div>
            <h4>{h.title}</h4>
            <p>{h.desc}</p>
          </motion.div>
        ))}
      </div>
    </div>
  </motion.section>
);
export default About;